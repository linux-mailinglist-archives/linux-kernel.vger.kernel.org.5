Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FAE793107
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbjIEVjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjIEVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:39:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B8185
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va2E0GQIybVUzIv5aOb0MMIE1FefYdSOgZXWfhv1njQRAJ/nZb9FRnJ5wwhDeBO5MKAdO+Tm31NYqvfOZcS4z0RG1TMvSOBYxfp37ToRunTtcRO/d0p0zjJsxGEmyBuDQuQvdcQu1y7iZ+irOUmOSStLb+hyGFac5sSDxrntgUewVpIqu/eBMqL/QkMMJLWww63i6hgX+05qg5jkNsTtQtoDLPmvq2PtYHtcf80QxiRLnmFNsaqwtr6tfE5PtESze76mlQ+j0eIdmmiUtGxHWeHz/UE7bLkVVPfayAHhUhWdWTdBNnpa2+BU1HpAtFtta9KspLixSRFr8NmvHo4H3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/Y4ExIQBpO0Ngmmd9S2zE/fnFMalwtsaWy3Pad3xwQ=;
 b=GvhfzJblTCp9YDi0+j7jA08pOdioFaf33O2rwkn/cVhYaMadQtAjjSJnszRDr2CRW38fl38RospMWl89A24jzs0WIrjrSFmOZP0Ra0vvhmUE4Y3PoxFZSa75j8c60+H/r6Go9HLuigIdQzozL+avCCD6uKS4rmDNZH4r4NuHU5VuBK4LFlVCxgAmEZFS8GDy05XLa5s//PYyavMTRW6fG+RQPb6v9KDF55o8yU8jJ1osgSLaTSnxXPNUAfLi0bxV5xaHTpoILMDfH7IVoB7odRg9lMkVo3P6eNVEhrwb7sxy0h7wyQ/RlJQ781aAJ/AGwt+er6MOeOZcmvlsBVu/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/Y4ExIQBpO0Ngmmd9S2zE/fnFMalwtsaWy3Pad3xwQ=;
 b=qL+JTt806DORPgGc2wObwnoURf9fnhMS+2w156PGABWv17xLCNTc7Etc1q0q1dpft54g40aZQKFcoEV7azfpMBgCnXuacDTy3i9A0oxDM7EGU/H6V7jqJ3z3NOCJHoqGWO+2tMA0X7LcYG5dWIRmGa5h6CpwSRIraUZtunblB7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 5 Sep
 2023 21:39:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:39:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/9] I3C Slave Mode support
Date:   Tue,  5 Sep 2023 17:38:33 -0400
Message-Id: <20230905213842.3035779-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: ccac1e4b-b698-4e30-526b-08dbae588492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzLMgTQXxFTE/kxDN5PRUN/RlVKSPsorJZTsj5PXXV7mTKTXDj6V3odvRwBKPRIpHG3pJkAO2BzjohA41aVPQ3w0ZADjG1IEDFPl0ft6eXTsuNi38g36UqOm2qFyuiFCG2F4Bg1/tEMUGApxDFr8oyM3Qf0DhS6cPZ5/Jh4vtPGgLUU5y0J+jYdDMfbqBmkHnzBFtVo+kyt4A+JVijAhtkG+D06kyYzCI/lWXftpo1hK00ppEfMVaVEoLrWFzhK9ar9HbifOzq4ZvzqfFhab9ryG4hacyPfTafF+03eAuyi9YDV4RtHQzb4Go37NU9EsjSFH7PnnzbF4fPD9kGJ2SvhWPcBOLSK22/Z0QRJbM7eYK1JiSyX99nh28KYYULIIRYZAXS9itqKMkuS3ne9ELdpLo6TXkilwR4Tt7GjZpJplSKhMshbQ7bB+EhcvpqQ/sVCG+6erm8+xi65NJ3UpBmAtSZVadl1xFsABvNNI+v7LuoMtnKkv6vrZeEG9HebiMZ32LtDscaECgqz6yzsRW2dpkhXZ7SPoWxB1DyyDC1WEObvoWZxjQZO/lEZJmvdfVwoUfo7YuHpWjeVQq1dTRXqAlWk/mbdLWdV7vi+/MGcBp+0TEVkYGzsVLvWavViU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(83380400001)(6486002)(52116002)(6506007)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(26005)(6666004)(5660300002)(1076003)(41300700001)(8676002)(8936002)(6512007)(2616005)(4326008)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3EveFo5T0tJRzlnMVl0U055QnZtemRVZkJKNTJBZlFibjFlZm9OcUZub2lW?=
 =?utf-8?B?TitsZzdEeEJnWVJmcnUxWXQySW1Ia0RPclNkSFYzMDFDUWltKyszbHZJdlpF?=
 =?utf-8?B?U2hhMDc0dldKTFlUYkMxSllNNFVjQ1hiSjJNRXcrNlpraFZRVDMrd1h4Slgy?=
 =?utf-8?B?cGVZaUMwTzYwbU1OOURRWDRXQjNSYk1UZFdjREhvbk5UVG1mVzBNN1pyemVE?=
 =?utf-8?B?b09KT1RMS1M3eEE2Tyt1NEdUWGZpT2xWaDJuUUV4eTZoTmZDVzdmSk03UFNr?=
 =?utf-8?B?eEI4djNWL2tDOXdQb3BvOGcySk0vR3pLSXVBTWZ0SVRtRkxicEI5TU9uRVg1?=
 =?utf-8?B?UnA2RFZCN2YwN2ZaR2pGbGlRbXRKSEZaMXJzclZyaXZ0WnlSU0c3YmhBVnVN?=
 =?utf-8?B?NHRmcFMrOVJoUHNoSDF3SUZNZUJwTTRtZERzMHBueGlwbHkyU1RBQ1FSdW1n?=
 =?utf-8?B?dVc1MTluYUVyeFNNR3FVc1IxdG9CZnJoZDl5Z2tFaGQ0eUxRWHFCQ2xtTzlX?=
 =?utf-8?B?dHpPSU5SZTRoMmVGQkw1Y3NBeVRFN2pkNk5Qd0F5YngrN0JIc1M5cXBudkhs?=
 =?utf-8?B?U0ZkMDhjOXVBbDcrbkw1OEhMRkJoOG4rYjkzNGdaakV4MkxPZlkwWlJOcFFz?=
 =?utf-8?B?SFJvYWtrNXhXcWRCNjhsaE4xZXlUOE5SeWR2R0lESVplQ053YzlzWmhwdE5C?=
 =?utf-8?B?TXVVNkN4Zkw3MlczVjlOMWJ2bHNQazd6WmZwakxZZDdVOHhlUW8xSUt2Rmpk?=
 =?utf-8?B?bzZtQTVKeWJYZXFMTm1nRFFQMUlGcCtHVFlvU1lqbTY1R1NlZnhVbkw2K1FP?=
 =?utf-8?B?b3FLTWRSY2dZMXRDU2ZrOEhISC9JTHgzbEI3UVJYMlhJcHN2ZlBUOS9aNWZi?=
 =?utf-8?B?dzYvVjZ5cWtnd3NJV015OWQ4cHNZYmhEQXlXODdRRzB6SnBIZk5tQ24wMjAr?=
 =?utf-8?B?aFBqTllPeDhLY1BIbUNpdEc1akZ1bkJEMThzUEpxeEI0WG1QbmRDbjhXRHRQ?=
 =?utf-8?B?dkZZNTY3NDRxM3FoTHQ4andrYmFwWHQ3ejJKWTFyV0Q1VFIrR3Fnb2dMM3dU?=
 =?utf-8?B?QkQ0cHV1TzZJTndLNmlBeDFRM2ZUUnlFcEpqeVVGVDYraDVVY050dW15dEFC?=
 =?utf-8?B?clNESDBYK0ZHenhuUS9GNERuWDk3enpGalF5RW93TGs5UGpudS9OeWpvN3hC?=
 =?utf-8?B?aWlKSldsRStjb0VJeFV1NHVuWDlDQVNwR1hZMFlHOFdBSzZNT0tBcUwyOC93?=
 =?utf-8?B?Ui9mbXVwcllkWkhtS1VoQ1krMlRFb1dvTktDMVhGNEo0Mlk4WkZ5c2NGbnJF?=
 =?utf-8?B?ajZKV2xLalJuandsKy9uWCt1eWtiOVMxSlhYVDBuZmRxRGVuYTY4RWNxNzBE?=
 =?utf-8?B?dmhlQk9xMmYzS0x2ZEVwbXBhb3ZMYVVSOWwyMy8vVnlrSFpSN3lSTnJ2N0Qz?=
 =?utf-8?B?VWFxeWRHTFFXeFRlNnlpWnZLRUhwOGtiSXdja25FS1VtZlFETFlxL2RiUThp?=
 =?utf-8?B?Y3QwQlc5QXBPMm5raWdDUkdoVHpOckJtZjlOSGIxY3lkcG1BdE9UazhBK2Mr?=
 =?utf-8?B?cno2enF5MFZXZEVBaEU5b2h1eWZTd1c5dm5iSDRCSDZicEY2Q1EyNGQ5aHNi?=
 =?utf-8?B?ZFpFMGRSREkvOVo2YjU5YTA4VUxmOHZ3NXVLRkNCV1prcVhoZGVqNG9sL3Jm?=
 =?utf-8?B?QStlT2hlczhZRkJtdGY2YUFjdmo5a0dhSERyY1ZGR3Q0bjJ6bER2M2JPTytN?=
 =?utf-8?B?dGRIeG5hZVJhbStXMWRUS1g4RFQzTVlqTDR6VmZJZlFNSVM1VmYvUjZtNy9t?=
 =?utf-8?B?QlVlTXJ4S0RCajR6NlRHaUxudXk5SjVzdGVhaXZwb3hZNlNrVWdRZ1ZtclhL?=
 =?utf-8?B?Y0pWaGdXNmNLSEltdm1Va3FoQ1FqT0ZYMmdxbnl4TGRnRGNyR3NhWmViY2g4?=
 =?utf-8?B?cDFqMW94V3RDK1pleGJGbGhkbGc2ZEVKSTRGT3laeU5nNlhabGRSZ0wvQ0V1?=
 =?utf-8?B?emJnSkhhQjJtaFc5TUtBWUtNSUdGakpwRnoyYkVDYk9OSHlQcnJWVHBQbHdv?=
 =?utf-8?B?aTNqdHBMU3Boa0NyM1VqNnpUbWFlZXFDZnNYdUF5SytWZ205UHNHa0t4aHlS?=
 =?utf-8?Q?RxmrpaVouZGiFZJ9ZMvMdjmSz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccac1e4b-b698-4e30-526b-08dbae588492
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:39:00.9123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPSXPbexU+FUb6qENTpSKTP/FXK10jvJcCmPmdPKhqfPEh3xO2xK9CjqQKW14WNjM4JpvvzpK1k9wtQoYcPn7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC patch introduces support for I3C slave mode, which is referenced
with a PCIe Endpoint system. It also establishes a configuration framework
(configfs) for the I3C slave controller driver and the I3C slave function
driver

Typic usage as

The user can configure the i3c-slave-tty device using configfs entry. In
order to change the vendorid, the following commands can be used

        # echo 0x011b > functions/tty/func1/vendor_id
        # echo 0x1000 > functions/tty/func1/part_id
        # echo 0x6 > functions/tty/t/bcr

Binding i3c-slave-tty Device to slave Controller
------------------------------------------------

In order for the slave function device to be useful, it has to be bound to
a I3C slave controller driver. Use the configfs to bind the function
device to one of the controller driver present in the system::

        # ln -s functions/pci_epf_test/func1 controllers/44330000.i3c-slave/

Host side:
        cat /dev/ttyI3C0
Slave side:
        echo abc >/dev/ttyI3C0

These patches have not full implemented, especially at tty driver side.

But it does not impact to review i3c slave part, especially data transfer
and configfs.

Frank Li (9):
  i3c: add actual in i3c_priv_xfer
  i3c: svc: rename read_len as actual_len
  i3c: master: svc return actual transfer data len
  dt-bindings: i3c: svc: add compatible string i3c: silvaco,i3c-slave-v1
  i3c: add slave mode support
  i3c: slave: add svc slave controller support
  i3c: slave: func: add tty driver
  tty: serial: add tty over I3C master side driver
  Documentation: i3c: Add I3C slave mode controller and function

 .../bindings/i3c/silvaco,i3c-master.yaml      |   7 +-
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../driver-api/i3c/slave/i3c-slave-cfs.rst    | 109 ++++
 .../driver-api/i3c/slave/i3c-slave.rst        | 189 ++++++
 .../driver-api/i3c/slave/i3c-tty-function.rst | 103 +++
 .../driver-api/i3c/slave/i3c-tty-howto.rst    | 109 ++++
 Documentation/driver-api/i3c/slave/index.rst  |  13 +
 drivers/i3c/Kconfig                           |  30 +
 drivers/i3c/Makefile                          |   4 +
 drivers/i3c/func/Kconfig                      |   9 +
 drivers/i3c/func/Makefile                     |   3 +
 drivers/i3c/func/tty.c                        | 345 ++++++++++
 drivers/i3c/i3c-cfs.c                         | 361 +++++++++++
 drivers/i3c/master/svc-i3c-master.c           |  52 +-
 drivers/i3c/slave.c                           | 441 +++++++++++++
 drivers/i3c/slave/Kconfig                     |   9 +
 drivers/i3c/slave/Makefile                    |   4 +
 drivers/i3c/slave/svc-i3c-slave.c             | 600 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   6 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/ttyi3c.c                   | 276 ++++++++
 include/linux/i3c/device.h                    |   1 +
 include/linux/i3c/slave.h                     | 458 +++++++++++++
 23 files changed, 3109 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/slave/i3c-slave-cfs.rst
 create mode 100644 Documentation/driver-api/i3c/slave/i3c-slave.rst
 create mode 100644 Documentation/driver-api/i3c/slave/i3c-tty-function.rst
 create mode 100644 Documentation/driver-api/i3c/slave/i3c-tty-howto.rst
 create mode 100644 Documentation/driver-api/i3c/slave/index.rst
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c
 create mode 100644 drivers/i3c/i3c-cfs.c
 create mode 100644 drivers/i3c/slave.c
 create mode 100644 drivers/i3c/slave/Kconfig
 create mode 100644 drivers/i3c/slave/Makefile
 create mode 100644 drivers/i3c/slave/svc-i3c-slave.c
 create mode 100644 drivers/tty/serial/ttyi3c.c
 create mode 100644 include/linux/i3c/slave.h

-- 
2.34.1

