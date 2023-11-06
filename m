Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1E7E2B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjKFRyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKFRyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:54:17 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A70AB7;
        Mon,  6 Nov 2023 09:54:14 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A6DZoEc010865;
        Mon, 6 Nov 2023 09:54:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint; bh=hkCYe1l6xUYkvqIlGfQh+kyRDN11vRM+BbEX5RRJW6M=; b=b
        mgSmyIyL6VBpzGxlDgyzlFHbOjoXHODZUahM5lUSbsOjcSpiuO35RbxYgP7w20V/
        vejpYu0L7jZ7pm9WWudMwuruUNnfNiT8Y4uveVu6slaWjuMYCeuckL0Q9FTLIM4Q
        7SLw1VdztTXYdr21RbgxkKy9NNq9jki6iCKbr1DA5PlA4PRcGlhynrc9Nn7DBi/h
        Dwo3SjPeBripyl0J4b0tTtThRTpHf3zUgyO5nzUe5fThodYoQCOE39zQhlUhoNiH
        Fzpb3bB/fBmDTyuVbSWEAeAPxNsLJpvXiaR630x9XZosqOJNaq0yiPZ7L/mvgAbZ
        7pUFnXomG546o3yQEmmSg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3u5jgseymq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 09:54:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjQCXTgDI/a8LsgYqX4igDqvycZxNg3XiDufxcH7OWbtooghRBYxvx7ilOdPnnQVapzYLRezobPW+8Lps6/HwJ3urkUXpTNmYbbgtAdDEi3TxzHMGl9IwLsfvI9dK1VVCCzDTD0tMp+ULSbzHuNA/J8JwK7FNoruvo9us8Wxfc8Svzr6o/GsWjVSpNe556rFdbFBXiifNMtRZ1gydA78yVMjfoWkKkjQTUnQscSuUQ4KJ0hsFb5EMnpp8ALtChQYr205L/E+dhSw6v/B/7akeNlxVryy7EsdTPWkbZTZw9cDfyYlaUYL5e/MqilkOL1NEJ6VGtHTGw5BoyUp+NfuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkCYe1l6xUYkvqIlGfQh+kyRDN11vRM+BbEX5RRJW6M=;
 b=g9yUR5hzyqknvOXCzMv7Q4CvikonTn+oKNHtwQlEhjI9VSuDq02hCywqPFTe5+qFa4JHndz63Mm+wvZbuHUOPNWdJOTvgrDEvU8gCEeFMWxhkuqu7OcYfUE1c3h3kZ96HR2VeiJCNJAIDXz32fxY3nQ7ecLNTfg8ONq3lggEv9PZljEMyUYo03D+X1gK1E5hT6NvZDvlD22brQeJesfA/Y5j7hBfNF8Aht+gF2T+2QBH6VoNJ4gM+SELddQM5uuAK5MujuDR9IB9ZfJ5qrmZt3RT4c6Cd70dhKlJiuwtA1vE5u8eSfx6Nh1v01ixVmCmA3DPeHgbdLGsnlRfIw3ukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkCYe1l6xUYkvqIlGfQh+kyRDN11vRM+BbEX5RRJW6M=;
 b=t7+w7qFIPsrw9t4UEsSY94FyUATJPVJAeDNfVmxw6Zc0yISvp+uVqWBAa/TMPiqeqJ1Qx67pKWtU6EvQ82Gc1vIPG/PX/hAtlcUzJrBO6o5VhHJS725zfMc3D4zesxV04Tqe4rqCmkaMQlPY5bdI4X+diVcOdyV3+2cxnHiCHmE=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by MW4PR07MB9446.namprd07.prod.outlook.com (2603:10b6:303:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 17:54:07 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::349b:3cfa:d8e3:df26]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::349b:3cfa:d8e3:df26%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 17:54:07 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
Thread-Topic: [PATCH] usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
Thread-Index: AQHaENgcIh+gRq3KMk2mVp77du/A0LBtkZ8g
Date:   Mon, 6 Nov 2023 17:54:06 +0000
Message-ID: <BYAPR07MB5381B9DA813D1046C950DE51DDAAA@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20231012044628.293070-1-pawell@cadence.com>
In-Reply-To: <20231012044628.293070-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzhkZWVjYjAtN2NjZC0xMWVlLWE4ODQtMDBiZTQzMTQxNTFlXGFtZS10ZXN0XDc4ZGVlY2IxLTdjY2QtMTFlZS1hODg0LTAwYmU0MzE0MTUxZWJvZHkudHh0IiBzej0iMTE1MzYiIHQ9IjEzMzQzNzY2ODQ0MzQ4NzY1OSIgaD0iVmhRS0hQRnRUd3AyOGdvVGozeG92S3hZT0FvPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|MW4PR07MB9446:EE_
x-ms-office365-filtering-correlation-id: fcf01dd5-76d7-4a33-efc7-08dbdef15f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /nD8RArXnBo5RvPb6UAGwsvbkJmPUczyw2swJGZsihJ7El1EOCxIj/lmwBVkqztoU2cW1cCdas7TyTIGQMEr9gciBtsu0Ei8Z+N3sfEIpBTYCQMjifSxUqRSLYc2YmnJMgKALPOTdH9CFJgVdCsxh+U5OlrNo9LpTysTP5FCNCdin4hHDtfuHfLbC/TKWq/61E1L6/HdNyvMR5h/4aiEtQHxm2lqK/OkJpI2FIkEMaVWlSFc5ekk/smVHxckP9+58FK3lT45+3RyyIhz7DEuufOHgjpdyE13IzB2YR70oFYQBrK4sS9axNVBvjino95l5fJYsWUKptCDaXxepdoRUweFern84nRPz+arvPG1cWVnB/McMZP36TU4fClzCVdArh9wh63s7NrizXZfjmbzN4DunTD4EDLd62DdtbzsliXMndr0X2nF5bstXcM/t1U9wAq1ZD1VHrmzMVjx5dqmkBHHR/GncUPyLxjqJizO5FfXR+WaofzSOnFashIuqUqX4diEGsN+gH3YSBg9H45wITZ11WahVfPUP/uIw/75FQ/8nRr0YFfEKcmIiat5at6/Iv/RJrww9EB9s8CNHhnJlbjNLoDQ6WW9izyeSWNa4kTzeFot9XsbBHfTdfrVgjdb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2906002)(5660300002)(86362001)(76116006)(66946007)(316002)(66446008)(54906003)(64756008)(66556008)(66476007)(8676002)(8936002)(110136005)(4326008)(33656002)(38070700009)(41300700001)(52536014)(26005)(122000001)(55016003)(83380400001)(71200400001)(9686003)(7696005)(6506007)(38100700002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kob4pcIwzWTIxo7vXL7qphGP9JHrX3VSt55Yz/2yK97Kh8IfnYyfs15vaXhN?=
 =?us-ascii?Q?Z5L5l9LUybJ9rgDclOqNH+GQ/Fx+rJJP4vvcTo8Pj4Qg9VAmZ1qV2KU5Y2uC?=
 =?us-ascii?Q?UddEiSi5x/J9hRwAzIaZTJSm/sFnitbCu6kv8P39CFEB7lBN0VT1N2YfwLCo?=
 =?us-ascii?Q?AYOaZq6VhNLTU9nWUlKMMQKorAPdCdFQ/ZEe7GH3+RywO9duQ+5QzHQrlmKm?=
 =?us-ascii?Q?ZT7FTeYkrcf0FA0QVfTnBCop7gEDp+MwJgoELPSr3Q1fYiIai/plTTQMGWI4?=
 =?us-ascii?Q?XBasGKSrX85qg2pCYDIDCeCeAg9x1JTXfQvuqNOP+a4eFYlktgguwPju1rLQ?=
 =?us-ascii?Q?IRe1f+XTI75tUaW6tPbLLdWlVt/pNVSwoMAZm40jJhEYrlZ7dYJK83J8eWSl?=
 =?us-ascii?Q?9f5JOLpXeYGDXWsXea1Q78pQFx6bpvmiNz1tXYBc9KFxNWEnrARfQPTkFXVr?=
 =?us-ascii?Q?KcNRyZgwRSzCd4pdG2z3Vrl6jPVtUbgxQHi3GS2bEAah46blXjekR1V7o76F?=
 =?us-ascii?Q?zgBmPz8ciyLevSjO6SQh68TdZZlKqCWugCBXwLKMgV0fcoCj4lytk/jpBoSZ?=
 =?us-ascii?Q?lm411DMorT7L5+Oq1nEleDMMC0pfeFgcSgbPwSWAzWWk20PzLul308j6bwyl?=
 =?us-ascii?Q?aRCeBtl5QjVt6Ir1MKM8U4hS9IpD4dMIW/otVhYkzwmzmFkRfS3kJR51ECEg?=
 =?us-ascii?Q?TVFx7mAFmlA4ZkmVB/qYjHvOvK0rf4EEpH+h2kB9fDoSKmw1j9MTOxzxypen?=
 =?us-ascii?Q?iL/lfdpZUaRlujV2ra57+SFd0cBMQo/nBoeKlFeEsQB1DJsWFv/ndlmjUzDw?=
 =?us-ascii?Q?+tKI9voDlNvZurpeC7kDm0C7TzmM+EeX8QeftnCeoU0w/8yP/kGp8wt7yL/j?=
 =?us-ascii?Q?x5khRe3sPC4FBkLVBIUG3Ksii2VvVAZeVsyjj5HbNNgwCVJCZ2NixP8WVLBb?=
 =?us-ascii?Q?uP4faLHRT5L8K91HAWTrSc9myWzsrHkIftfnngKCIwGsBd3AC7lshrLcvvjr?=
 =?us-ascii?Q?yQNHTfE7/ZQ6C8lO2Muo7mc6C4p1yi3Xxn6gWjWkZ2qT0Vw7/gSMU+5mMgXq?=
 =?us-ascii?Q?CHbP/+i6JXah9kT1iRDb3kXpK3fkdDMNyDJq03b3BELUml2Jjq4qwne/JeYj?=
 =?us-ascii?Q?kGdu4btwaJ22YJ29GPOjYIUQ4+8f0lwYFcyNpA3TspWbTWVHd12OL2en+jrB?=
 =?us-ascii?Q?I4TK7qjPIpYWG0YaqaY5Ny0f21wJnVrTfECkWjkyiYJdStADnGcDeAFeqdTM?=
 =?us-ascii?Q?r/iGwjlyS7DyOSrOsHFNpe1lX3+C1EleuGiBWOlhVj8xjp2OEFE13EDAO/6m?=
 =?us-ascii?Q?PRo+CBS6/B7aO9AEEtlK30FJ7WJrMDq3uTJrUXem/YOU4Jr1DiL3tTCiy6P7?=
 =?us-ascii?Q?gc7LO+sZeJK3bzBB3hUVsq2ehkEmIRSmzzklBTVDryriG/VgIXInj2eUcfan?=
 =?us-ascii?Q?2IPrJIBpN3Vd9KTk1jwMAQP6Fl1yk10MN3PdeZ9d7mQ3B4Fk2h8plwSZQsri?=
 =?us-ascii?Q?zqb/9b80IMgUNtIlyZc7ROJU5xCAM5vp65p29fa7HQcqgXhquA760I5Xyi14?=
 =?us-ascii?Q?NkPfSGoqiBQ4+4fgAQ+RiA0nGB+AZ1z6mIktRxcu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf01dd5-76d7-4a33-efc7-08dbdef15f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 17:54:07.0376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKH3NjQvH1JtQwvGDxhUsM23Eqi/5Ay0DKWH3M1zv8gEyDai23pIGEkqhGkHqp0Rc486NQD9WGtAVkJBxaOmNb6URaUAVre+w3Vhgnx0RzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB9446
X-Proofpoint-ORIG-GUID: 1VhwieeMcQkanuQWqDrwg4essVEfWBvQ
X-Proofpoint-GUID: 1VhwieeMcQkanuQWqDrwg4essVEfWBvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=916 malwarescore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2310240000 definitions=main-2311060147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please ignore this email.  This patch has been already accepted.
It has been send due to some server email issue.

>-----Original Message-----
>From: Pawel Laszczak <pawell@cadence.com>
>Sent: Thursday, October 12, 2023 6:46 AM
>To: peter.chen@kernel.org
>Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org; Pawel Laszczak <pawell@cadence.com>
>Subject: [PATCH] usb:cdnsp: remove TRB_FLUSH_ENDPOINT command
>
>Patch removes TRB_FLUSH_ENDPOINT command from driver.
>This command is not supported by controller and USBSSP returns TRB Error
>completion code for it.
>
>Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>---
> drivers/usb/cdns3/cdnsp-debug.h  |  3 ---  drivers/usb/cdns3/cdnsp-gadget=
.c
>|  6 +-----  drivers/usb/cdns3/cdnsp-gadget.h |  5 -----
> drivers/usb/cdns3/cdnsp-ring.c   | 24 ------------------------
> 4 files changed, 1 insertion(+), 37 deletions(-)
>
>diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-
>debug.h index f0ca865cce2a..ad617b7455b9 100644
>--- a/drivers/usb/cdns3/cdnsp-debug.h
>+++ b/drivers/usb/cdns3/cdnsp-debug.h
>@@ -131,8 +131,6 @@ static inline const char *cdnsp_trb_type_string(u8
>type)
> 		return "Endpoint Not ready";
> 	case TRB_HALT_ENDPOINT:
> 		return "Halt Endpoint";
>-	case TRB_FLUSH_ENDPOINT:
>-		return "FLush Endpoint";
> 	default:
> 		return "UNKNOWN";
> 	}
>@@ -328,7 +326,6 @@ static inline const char *cdnsp_decode_trb(char *str,
>size_t size, u32 field0,
> 		break;
> 	case TRB_RESET_EP:
> 	case TRB_HALT_ENDPOINT:
>-	case TRB_FLUSH_ENDPOINT:
> 		ret =3D snprintf(str, size,
> 			       "%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
> 			       cdnsp_trb_type_string(type),
>diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-
>gadget.c
>index 4b67749edb99..4a3f0f958256 100644
>--- a/drivers/usb/cdns3/cdnsp-gadget.c
>+++ b/drivers/usb/cdns3/cdnsp-gadget.c
>@@ -1024,10 +1024,8 @@ static int cdnsp_gadget_ep_disable(struct usb_ep
>*ep)
> 	pep->ep_state |=3D EP_DIS_IN_RROGRESS;
>
> 	/* Endpoint was unconfigured by Reset Device command. */
>-	if (!(pep->ep_state & EP_UNCONFIGURED)) {
>+	if (!(pep->ep_state & EP_UNCONFIGURED))
> 		cdnsp_cmd_stop_ep(pdev, pep);
>-		cdnsp_cmd_flush_ep(pdev, pep);
>-	}
>
> 	/* Remove all queued USB requests. */
> 	while (!list_empty(&pep->pending_list)) { @@ -1424,8 +1422,6 @@
>static void cdnsp_stop(struct cdnsp_device *pdev)  {
> 	u32 temp;
>
>-	cdnsp_cmd_flush_ep(pdev, &pdev->eps[0]);
>-
> 	/* Remove internally queued request for ep0. */
> 	if (!list_empty(&pdev->eps[0].pending_list)) {
> 		struct cdnsp_request *req;
>diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-
>gadget.h
>index e1b5801fdddf..dbee6f085277 100644
>--- a/drivers/usb/cdns3/cdnsp-gadget.h
>+++ b/drivers/usb/cdns3/cdnsp-gadget.h
>@@ -1128,8 +1128,6 @@ union cdnsp_trb {
> #define TRB_HALT_ENDPOINT	54
> /* Doorbell Overflow Event. */
> #define TRB_DRB_OVERFLOW	57
>-/* Flush Endpoint Command. */
>-#define TRB_FLUSH_ENDPOINT	58
>
> #define TRB_TYPE_LINK(x)	(((x) & TRB_TYPE_BITMASK) =3D=3D
>TRB_TYPE(TRB_LINK))
> #define TRB_TYPE_LINK_LE32(x)	(((x) &
>cpu_to_le32(TRB_TYPE_BITMASK)) =3D=3D \
>@@ -1539,8 +1537,6 @@ void cdnsp_queue_configure_endpoint(struct
>cdnsp_device *pdev,  void cdnsp_queue_reset_ep(struct cdnsp_device *pdev,
>unsigned int ep_index);  void cdnsp_queue_halt_endpoint(struct
>cdnsp_device *pdev,
> 			       unsigned int ep_index);
>-void cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
>-				unsigned int ep_index);
> void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num);
>void cdnsp_queue_reset_device(struct cdnsp_device *pdev);  void
>cdnsp_queue_new_dequeue_state(struct cdnsp_device *pdev, @@ -1574,7
>+1570,6 @@ void cdnsp_irq_reset(struct cdnsp_device *pdev);  int
>cdnsp_halt_endpoint(struct cdnsp_device *pdev,
> 			struct cdnsp_ep *pep, int value);
> int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep); -
>int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
>void cdnsp_setup_analyze(struct cdnsp_device *pdev);  int
>cdnsp_status_stage(struct cdnsp_device *pdev);  int
>cdnsp_reset_device(struct cdnsp_device *pdev); diff --git
>a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c index
>07f6068342d4..af981778382d 100644
>--- a/drivers/usb/cdns3/cdnsp-ring.c
>+++ b/drivers/usb/cdns3/cdnsp-ring.c
>@@ -2123,19 +2123,6 @@ int cdnsp_cmd_stop_ep(struct cdnsp_device
>*pdev, struct cdnsp_ep *pep)
> 	return ret;
> }
>
>-int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep) -=
{
>-	int ret;
>-
>-	cdnsp_queue_flush_endpoint(pdev, pep->idx);
>-	cdnsp_ring_cmd_db(pdev);
>-	ret =3D cdnsp_wait_for_cmd_compl(pdev);
>-
>-	trace_cdnsp_handle_cmd_flush_ep(pep->out_ctx);
>-
>-	return ret;
>-}
>-
> /*
>  * The transfer burst count field of the isochronous TRB defines the numb=
er
>of
>  * bursts that are required to move all packets in this TD. Only SuperSpe=
ed
>@@ -2465,17 +2452,6 @@ void cdnsp_queue_halt_endpoint(struct
>cdnsp_device *pdev, unsigned int ep_index)
> 			    EP_ID_FOR_TRB(ep_index));
> }
>
>-/*
>- * Queue a flush endpoint request on the command ring.
>- */
>-void  cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
>-				 unsigned int ep_index)
>-{
>-	cdnsp_queue_command(pdev, 0, 0, 0,
>TRB_TYPE(TRB_FLUSH_ENDPOINT) |
>-			    SLOT_ID_FOR_TRB(pdev->slot_id) |
>-			    EP_ID_FOR_TRB(ep_index));
>-}
>-
> void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)
>{
> 	u32 lo, mid;
>--
>2.25.1

