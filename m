Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5EB77F4EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350210AbjHQLTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350251AbjHQLTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:19:37 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9FE30C2;
        Thu, 17 Aug 2023 04:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv/X7wJxjQEsYfXI4r2X2qVaTjY4jEDH+7yav4qmjy7Zk496nupVZcP/dI9ae/7XY210o+FVStSaHled45x+wpVTIDGCsk3zOBzjQvyc+aZMJADzzotDrKyQvO8tOAHo0R+oAEIWKh5cwbkajzLSRSRBtC4ivBEzu1jNNoQXpw2YE+dxsfsrt/as6jewbIv8StGTLJLANMGN89j1gYFHrNl9UIkBkL8IoZYdRvNSToF2lXSX25eymX/QFo2j91VLpgWWGywA57YFyPRkKIYUFJEEYpeTkv5/2drsPOKtEZ+JXDBql6dsSpZqdWnDCk8wKhNUfBpVjwzkkvuWWlrLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWn1lHSlnUsEZBNtqOXwaYI18/VOqL3XOBJF6Xe4VUc=;
 b=I/H8ij3clqlIeQaefky2lQlQuSH9tryW+6LC6m72l6qJBQT1Zo76/OjKw5SGDFLPtHhMK9LwjvhjWbaIIs2Q78935l5v3DTnU8xH8AkO/8rNnhtX4l3kuaOmzByRSphTC44RrKAUd572hIGKfUAraaLOC34NyhnsaicJwChqhhVHrjqz2/cn0ljM/wNF6j5BeB8uKpyvppIKEa2cVf1L2C2qkv1kd1EPeiv7SkuPgnN68KXz53/wXGD0NkRsiZPibFENgADG5FtkR3gHFOOmanzf0c6NrG5KBXfRUi5rp7bjJcpfmoBBMDWVtz4bLhyUHFa1BDGX7VqE9qYii84XSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWn1lHSlnUsEZBNtqOXwaYI18/VOqL3XOBJF6Xe4VUc=;
 b=DUbHRsH5EKYsQsh3ha/a7/sup3DpEzlCuca4j8pKtfhmoJHmSywulTYEEo+5gdaLS3pHzqRNe6dlSVNnILDTSqerbePcnfXTd1rJ/lIOFcjUF0VzAmRuyuwkiGMMPb5KDAsyAkvjfmDIx5VJbyoG8Cxrck1s4G/Ay7HDDqPo/eM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS5PR04MB9856.eurprd04.prod.outlook.com (2603:10a6:20b:678::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 11:19:30 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:19:29 +0000
Message-ID: <8df2bc8f-7909-76c2-8b4c-afa5272c0053@oss.nxp.com>
Date:   Thu, 17 Aug 2023 14:19:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v1 4/5] net: macsec: introduce mdo_insert_tx_tag
Content-Language: en-US
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
 <20230811153249.283984-5-radu-nicolae.pirea@oss.nxp.com>
 <ZN00NB7RayXAl80f@hog> <c28591b1-812f-b593-ef83-72e972d5b7bd@oss.nxp.com>
 <ZN32-0fwIMtrc9lu@hog>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZN32-0fwIMtrc9lu@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::10) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS5PR04MB9856:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f25fcc8-7007-4b77-9d1f-08db9f13d2f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxKAP7OPucsUOotXcHleq0ZrgjND0KYstummsO8U4jf169QNhFvaSiHoeikfcPi+ENlQZX032cvVDd+AuU3VsprJAd6NWkEL/KlqYPDkS0wc73G2dbuCZBWpUqZjzL2HNRwyCuk+537/K8bIdYb4Mv7wc/DUjQJyxkGBO9cSdwOI6mI31qcOaTFxjweYJWDrcyuxghti0cqR93Py/SYV6nCliSxv/MJMvMgSBsUV1z4uh0/O8+GjFKKkI0KRlGXMeA2HkW4K/s+lQ4YBX6Kxdwp/odlGUFGBBiSZHodWQrtN/q/Mh8YNAqL0HIBWRUMlT39oC9xlcKT/JoqpbE3F2TOvynP/AB8YH//TZNMww/oAkMWwQYGAQRMkR36ni9GqwVTgVk8PQkRnUxg6zwC5c0Rp8+QoMZCYILtsG862GEMZpEVADed8KDHUyLT7nheNoCeZBE3GV9oMqMDQkJGSkMIveo9b3jnaIitpHOlbQMJjQ5498ElazpFCAAXIojzuY38SDc5Wty0jfL5wkAtHfayeehIkxPfsj0CSsGjDgWy+L+bxUDXvMuadoywve34JEWoNGzj5iYy6oiJn4fttSqx/MOnk4GKQk1hlVnojWtRXY7tbHR7FbQB9fxH3xwEg9KvwpSbPWaUrPHfnkNsRSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(6916009)(31686004)(5660300002)(41300700001)(38100700002)(4326008)(8936002)(8676002)(26005)(2906002)(31696002)(4744005)(83380400001)(478600001)(7416002)(86362001)(53546011)(6512007)(6486002)(6506007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0NPc2NTc1lNdHc5REZpU2pwNzRvRXRuRkI4ajR5UlZ3NG84dDhRa00rRm9B?=
 =?utf-8?B?KzRaczZLb3RTY2oxQXRlaHI5RE5zSGd3WXRndWQ4a0FGeVZMMWFKWnF3RFFK?=
 =?utf-8?B?NXlKWGVqeko0YUY4NU9KeGYxeXJkRy9hQ2tFY2wrMUh3aE96WHJGZmxST1Qv?=
 =?utf-8?B?dXNobTBsdWZmdHMyVXlLaldta21OcWI1OEExTmI5cWs2ZVNpYVhURjQzOWdw?=
 =?utf-8?B?N1ArVys1UEhzZ3MyMktHWU12OVJRSUNaWG4wSnJJeWxHWm9yVlJTSHNOSG9C?=
 =?utf-8?B?UzBPVnc3akFLL0ZzSkpOaDQ0Wko5NlQ3TlVMc3ZLbTV3Z01XYTdtQ0lrRkJI?=
 =?utf-8?B?VWtYQllXWkNmNDJ0M29pTGVxSnF2OVZZWUtBVFhoVkhobEpTdzkzbUxrVDlO?=
 =?utf-8?B?bHg4WUkwNnJsSmdJbitkeHJrWkgxc0Urd01ZODRvR0diZ0Q0STNyMktXUG4y?=
 =?utf-8?B?cWJ0bXVzTzJjUVdjRVVrWGV1dFo0YUpFRDU4UVAxMXkrYnQ1bUtRVVlGNzZ2?=
 =?utf-8?B?OTJSbFJkR0V2OXR1dEpkYndMS0F2SXpFdy96em02UVMrWC9wZ3o5b21LcVk1?=
 =?utf-8?B?MUUyN2RueWNlcjdUZmk0aGRKU3ZtTSt0RTVQcEJHcVlMeGhKVlpSMTM1Wk9z?=
 =?utf-8?B?dVdUQ2tLelJPMVo2Q1hBVktCZHZXZEEvTTVLTENUeDBQYkZVcU54SjFVbHN0?=
 =?utf-8?B?c2wxcGhZT0syTm5mM3hmbG4xTVBlY1JrSER6VFJad3kvV2FQT0x5QzhtSmlh?=
 =?utf-8?B?N1FxU0VQU0EyTnhJVlhWdG5lMXRoMDN3UC9oRUNkZm90eUxSN01Cd0kyclZS?=
 =?utf-8?B?T1BxUk9tVDNzVnlNM21pT2FmRHZrU3Awb2FmZWdzKzFTRDRGSktHOHVNZmVr?=
 =?utf-8?B?UVlMMzFKRjZ5TnZUVXUvOUozN2NsM05rK1VMc3cvVjBCNzI4bDlqVVM1RkFi?=
 =?utf-8?B?S1paNm1ya29vV2IwV01oV0FFVFYxL1FLOC9qbmdGWEVSSUp2eURHMHpoUWU3?=
 =?utf-8?B?OEtXeDZLTkZZZzFKNVJ2aVBRT3NWK25sU2xicG81QjV4TDhYbndQc0dhV2p2?=
 =?utf-8?B?TTVmSnBoQ3lMTnJvTDRsWlVsVE9sLzNETXM1MTdkR0EzL3FGUFNlZVpxVVF6?=
 =?utf-8?B?M2F2Zkt2QlNqc1JYcWllRi8vME56NTJKYlFnMXNvMy9xaGVUL3dJU3NJQ2Jn?=
 =?utf-8?B?V2liYWdZMkNxdmlZam5WaklGVkwxdWwxbnFiMnFTcUM1T3hHTFBMYStxYWtp?=
 =?utf-8?B?L25KYWJhTlE0dWIyVk9JdzZPaFlVQmFTYWtVV3NLanRlTFN2SlRrbG9tTVNO?=
 =?utf-8?B?b3RhdkRCK1JsdTA3ZEd3RzEyekJMS1E2WnBEblV3cTRlcm9SeGhnVWZsQ29O?=
 =?utf-8?B?SUZuTUszd0pxa2s3TDdLU1I1bGc1T2dGeFdPcllnQzBIeDNaZXNOSFF2YzJO?=
 =?utf-8?B?TzMzVW1zRXhkOVY0Yk5YVUF5TUFFckF6b1l2ZmFuUi9yejZLK3dybjgxdExx?=
 =?utf-8?B?NTNlT0p3a3BDNFhHc1dQc1RRcnQ3ekFkb0lFL3RSVmhJN2VqcFFtQi9DbFdT?=
 =?utf-8?B?cEU3TTJlZndySXZreVJXemg5NnJFeElMY3hVMitCOHBMRnVHRE81TWowblVl?=
 =?utf-8?B?dW05Z0duRXpDcW0yeEtvYlZYL2Z3RnFvRTBGM0V2d3Z2MkJRQUpIeHFpbFRm?=
 =?utf-8?B?ZGN3bnJFc0IyaWlQZ2tyT1dGZ2V5ZmxFUG1yblBNV2Q0TUN3SzNidHJjVG1z?=
 =?utf-8?B?ZFV6c3dYRlluMlkvMm55OW5QVHBob0ZYaG51TUpDc0c1ekIvUk9Md1hibUlZ?=
 =?utf-8?B?Q2M5Vk15S1lnbHRjTGNPZlNtbFZodnBkNG5BWXFTdTAzWjd4bndpR3R3TE1j?=
 =?utf-8?B?ZS93WjVSUmZ3ZUt3ZzhkVWkwd2N4SDFkNDE2YUIvbzRRS2RVR2k1SWtwQjFo?=
 =?utf-8?B?NnVtYkovZ0sxRlFGL1hsdFhUdlo5OHRmdnRDMUt6cnk0SEJDWnB0VmN5Q0RW?=
 =?utf-8?B?WnlEa2IwZkdGRE02RUY4NzNXU1RIemFCaUNIVjN5OVp2VVlrNEJLS1BLSVp5?=
 =?utf-8?B?cFEwcUdidnpFYnljQlVmSE83ZVFDLzVFSXNPRjgwN1BIZExEY2I5RzZRMzFI?=
 =?utf-8?B?c012bGwvOW5HZS90S01JLzBYR1pUU2RuK0VWR0xJU2QyYnh4RVBROFZZY00r?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f25fcc8-7007-4b77-9d1f-08db9f13d2f7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 11:19:29.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCIKP6bc6JYDOOi7Ma49U3hz9k82ENLbZ74WaYLAdYeW5rnGP0PB6Qg0U1SwVPgz4a88ts2HCslHTEqfvdr/E/TB3a+2t2BlthvWRNEPNyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9856
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.2023 13:31, Sabrina Dubroca wrote:
> 
> One more question about the ordering of patches in this series: is
> macsec offload with your device functional without this and the final
> patch? Otherwise, I would put this patch first, and then the driver
> patches (either collapsed into a single patch, or preferably split out
> if there's a reasonable way to do it -- patch 3 is really huge and
> hard to review).
> 

MACsec offload works, but if the frames are sent back to back, then some 
of them will be dropped. I will reorder the patches and split the patch 3.

-- 
Radu P.
