Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF5776223
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjHIONH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjHIONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:13:05 -0400
X-Greylist: delayed 108 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 07:13:04 PDT
Received: from mx-relay91-hz2.antispameurope.com (mx-relay91-hz2.antispameurope.com [94.100.136.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8431FC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:13:03 -0700 (PDT)
Received: from mail-am7eur03lp2237.outbound.protection.outlook.com ([104.47.51.237]) by mx-relay91-hz2.antispameurope.com;
 Wed, 09 Aug 2023 16:11:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMqjadELvkFJfkOin83EzNBy9bNvIbCp8Li//B1IL8dtiLzQDIvOWrxnlyiwuz1q5N7heg6j6ydH3p6ZleF83rP1KNXykAoptH1vJk4+4NmNFuaIVDtpx730fXD0ex2wHh9xzTdQP98q/Ilk+D6S5nzmG98nN6b0wvIah/IHORxAPOuIohOF3baIQiTSSwpZWaakb+JvESFGG8kiJkp+LAQK+YC0S5aElGsdPXHa/E/ML4Tr4P1wjH6zIEoKToDw7l8uwwGjFyoOXhFVWtuEULC5R5KDA6HaDnkcVNIkbEwIcifN7v+w3YqJpTjiFBsWL+GpEcmy5aDGN+zNwK0FwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GHqTskDB2Qj0EXn+BdpR2mLp5bYuHaVQWFJXfGRMwA=;
 b=EwT9/LO/ClPqYyrxZ7FVCO3Ose/T/61WTAGhHtw0Kt600wIvvqIMj25vZ9oS9wVvwXILfYfXi4I8aSD0PUqigiD35qJ0CpHtSupLfqx8FjKxL9XSrPgor2OAO/kVChyLE/DxJvpkrn8txjcPBD0JU4bx5A9//Q6VN7LQX1XJaxnWLAqFuJc6r/vkRDKkUNuCGFHLgHJq/MXv6MhoLrZYoHLhmTp6Kh5hiZzsiJW3tfM75Dbk8B4XvrzWV0/CVJGAdkDu+c02NujJaJcrL80MDyFQutMuEsupBzQNqsTtA0OEsJMj4JgKzBvOgiRcL+bDP5Um7Ko+NDBYcXcCM9O6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GHqTskDB2Qj0EXn+BdpR2mLp5bYuHaVQWFJXfGRMwA=;
 b=aIICCJ5rqJuO0ITOO9k+9xFDuhMcgoPeEMCcKXkNW0tAnqNCtE6Z3BvtekKPPf5dkZoJ9DiS7cRturQLn9DtP1d/dQIabeAPL0RwCxyntMXyKg1baBQX12fZSXtfGnkAdafgmHRDsAs/x7S1qpdcghHrYUdP+vE94+t4QQpjbro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::5)
 by DB9PR10MB7098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 14:11:02 +0000
Received: from DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8775:67dc:1840:d08d]) by DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8775:67dc:1840:d08d%7]) with mapi id 15.20.6652.025; Wed, 9 Aug 2023
 14:11:02 +0000
Date:   Wed, 9 Aug 2023 16:10:59 +0200
From:   Stephan Wurm <stephan.wurm@a-eberle.de>
To:     hch <hch@lst.de>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-block <linux-block@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
Message-ID: <ZNOec8JmndA63Mnh@PC-LX-Wurm>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm>
 <1293911429.1782934.1691445776353.JavaMail.zimbra@nod.at>
 <20230809135308.GA32214@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809135308.GA32214@lst.de>
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB7436:EE_|DB9PR10MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ef0352-c5a0-4a3e-fad5-08db98e2768b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BA4YQdCXel1ww3/B6C55Co7MbqjcyzHdQccbtz6J6ue2GcMinGiezFtfsEzEExE4dRQIfi9C6jfLSWDXTAvISH9Ug1HRxC1/BslO6GKTg2IIG98x8xpT0fqoez0xk8eL2MWtMOCHDvgRMSDJpGAofVbGCNAkQMHc6jv1ZWm+3+00bPx2TaGnkTgubi5ABubaKZdSAEUNuDGJ3R7r4NayeiEGp6rYLtwTrgSiybZJS0dnNozF6wLzEJaFPpwJRzklnV1W02Ob6FJ8TUpnFMwAfsgR4GaVAMgW1T6FDBmuEoK5ZCHzmyx4qBgEj7DNE1wiVSQYDje/W3dgVR4ZJum8bRoFyWj3tiX0WwEXbQC0933tzwh6gUWiBBC6wUs9y+L4ZGoxcpGpH3w5tA2vay/kj9XkbkAzqRhd2wveaYMuFWgBagbGTeZrc0hGvaG9UzihX/S+Anp5w9TY16O0Pl02Yri89dJSwhu5dKMrhF4KqS0/T2Gxp175VWT9uo2nrd60YzTji9wDnUd0eT3V+ZpX2VRJgO+jrB2EfL4aEvLblGEm/6G109jXTrocToq8QO0q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39840400004)(346002)(376002)(396003)(366004)(136003)(1800799006)(186006)(451199021)(9686003)(6512007)(6506007)(107886003)(66556008)(316002)(38100700002)(54906003)(86362001)(5660300002)(44832011)(558084003)(4326008)(2906002)(66476007)(8676002)(6916009)(33716001)(8936002)(66946007)(41300700001)(6666004)(6486002)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5DRHluQ2pBb3RUeGwvMEJrV3JnYWhTSnRrc2E0MjBnaHo3KzVUUGV0ME9l?=
 =?utf-8?B?N2hRbXhLeVRKT29JT2NlKzM0UmFDeDZ0L2J4U0c2T0lNV0NWdEZsMXFydm5H?=
 =?utf-8?B?ZG55TlFPZTVjbVFUVGwzanFEYktCQ3hNaElVLzVLajdrdXlFdVplNkdlNE5S?=
 =?utf-8?B?bXhrT1Fic2RuVk5oeFBieVVXRzJqMHRPc09idGtsQlExVTRTd1ZOb0lWWFR4?=
 =?utf-8?B?MGJud3pxUGhVV2RJK1piTHRQNmF3RVlmYWU0QjByUGJ4amhYY0p3R2tTcHM5?=
 =?utf-8?B?ak4wNXR3QllBZ1cySTdyZFF3amlvUjBlZGthTzdVRmxFT055OTMvMEJUQUhW?=
 =?utf-8?B?L080eDhCRms4dElVdDZQQWthYVJyM1ZoZENrMDh6WGNGL2RFU3ArWWd6Vkwv?=
 =?utf-8?B?VVF6US9wN1FOdFFwcmpFVUhiZTQwRi94TTZtb2o0dytnK3BnTlNuZEt0WERW?=
 =?utf-8?B?WFd2ckZsWUM3RGkweWpTMkxoRHFVWXRZQUZpSHhsMEozYWpiN1RCZ05xZEtT?=
 =?utf-8?B?eU90Z1cxWWljVmtvdXlQVklHYWdjYlkrVEFnSWNGMlh3TUV0ZVhkMDljQU9J?=
 =?utf-8?B?a2R5NHRjVEVYN2V3eWdjWXVXQkxwYVBPNE1UUFA2bGVBMU0zMmFmZmFFQ1Jp?=
 =?utf-8?B?dVFxYTFWb1p5RjdlNEJXOEpKcm80NXdCM21mcGtqQzdON1JucFV1K0FrU0VN?=
 =?utf-8?B?Q2dQZi9NMmhKcThoTVdTRnlmUGhMTklNRkg5VUFOM29TUDk0NkZqeEFabW5U?=
 =?utf-8?B?V3V3M1d4ZXBpSlNXOWUvWGVNSkhRNm5mVHhlMmV3bXdYdWxJZmJCWkNxUmlJ?=
 =?utf-8?B?S3k4aGVYWGV4ZEdNTUNta3RLWG40Sm9UVm5WeEVyZ0xJekNSMDFlWFJPQWpz?=
 =?utf-8?B?UEtVdHNmVmZSaXdBMXZxcjk3UnJlWlNRUEd6QWdXNkVRNUhDQ1pJZ0U3czJK?=
 =?utf-8?B?SEt2alNBVWMvR3dXSHN6SUIyVFFGRUlWdDBLakdrNUxDSVVjWDdod3BBYUlS?=
 =?utf-8?B?dDYwelAvajVSajFFUmtoQWRhMS9rcVFFZXFQNVp0MWcyZTgvTkRGOTJDZTg5?=
 =?utf-8?B?bmVIRXpTRzRGRXVvUDZmeTV5ajUvY201cWNWcWhFMjlMUm1LeGNwMEVKWVBF?=
 =?utf-8?B?azc0eDZGWTA5K3ZyN0J4ckxZNHc4SDNqWSszUUF4WXhpRjlLN0tqeU9OQVZV?=
 =?utf-8?B?bVl2RWpHZ0hyUDczZFdkaUR5UFpRWHNRTDl2QkgvQ2JDaG5sRDliQ1RVRFU5?=
 =?utf-8?B?UkRaWGVOQmVtMEpKbFhRUHFCMHVnTTdGdUdoOElsc0FCd1dITnNoQ3BieEJ6?=
 =?utf-8?B?dys3QTV0SFp0VllyVVlMLzl5UW1UT2E2cXcvOTUyVHNBY1JlUEk1cWl4THVH?=
 =?utf-8?B?cmxISkd0QXUzVlZvb1hLSkNYeWU4TUM2WEhwdEtUZ2Fsc2F6UFVMam5LOFhP?=
 =?utf-8?B?L3VpZXNtVk00ZllheitNNnMwaFlvMlorNTIrcHJKTXZuem5LbUtkUW5MY2s0?=
 =?utf-8?B?V0tmakxxNHJHd1R3M3AvN2hjWmw4VmpyL1hWQS9qUmtreFNUeno2VTlKcGtI?=
 =?utf-8?B?eWk2b1hEbGo3UTNUdWtWaUJqNTRTTW1uNVA4NTFwelhpZGc2QmxqSGJlUWJT?=
 =?utf-8?B?cHc3ZnhqckRSSHhWMFdBb2owWDZIbU5tVTdNN1BhZVcyb04wS0tWRHV5dUFD?=
 =?utf-8?B?VXNsTmNNUUhVTkc1TFpraUU2dVdqa0NzdndMS1hhOG0wZ1l6d0d6anRDWGxV?=
 =?utf-8?B?bkZmdjZLYWNUY1BhTjZrZkRpNzNJU1lKRGxwdHY2TlJwQ1EwM3ZobVFaQWMz?=
 =?utf-8?B?Mkx4d1dtRUJNQ2p1a2lJWG94dlI4YjdHRGRPcDB1R2NEejNxcTJ5MkFybGha?=
 =?utf-8?B?S0NBa2xLZGR6b0Q3czR6d2NGMk82emhwMGIvaU94WHVqVzltK3hEcFdQaHRC?=
 =?utf-8?B?SzBRZ1lSRU1oUWJBejhnTGxnZDdGNVBpVlphNEZTcnpEUXZVWlJSa01yWHF2?=
 =?utf-8?B?NnZYcWhnMGZranc4VjVLbHg3QVRaRSsvem0rVEtsRVlGSDRLM3Vobk8rTXRW?=
 =?utf-8?B?UE9hVTlKS09PVGVQR3JaTzkrajNVd2VKWVdrc3Vwam01eEtWM3RVQlMxNk9D?=
 =?utf-8?B?eGkzaUNSdDd6OUxQbnVUZHJFTG0xakp4SHc2Z0lHcHdlbkxKRmdpdHBvZU5K?=
 =?utf-8?B?UVJBdmlCOHFQNU1yNXp5bmJ5TW5MN1p0L1lKOVVOUFhoYko4ek1KekVadGl4?=
 =?utf-8?B?OThES0tMTFZvME1Eay9FejVkY1lRPT0=?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ef0352-c5a0-4a3e-fad5-08db98e2768b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:11:02.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64f0PIGQZlexaHDbk5j1jNOej5VUpYTdvxYl7K7Bc6WDnf3iP8JGm84beFgpl7d4/sylgLfkAMf+uGpTOGrf/2s5CVJyLXXnJpb9SW9BS3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7098
X-cloud-security-sender: stephan.wurm@a-eberle.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: stephan.wurm@a-eberle.de
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay91-hz2.antispameurope.com with 4DCE810C45AF
X-cloud-security-connect: mail-am7eur03lp2237.outbound.protection.outlook.com[104.47.51.237], TLS=1, IP=104.47.51.237
X-cloud-security-Digest: 15c4249789ccf6e0cbf0d8cc4586b352
X-cloud-security: scantime:2.667
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09. Aug 15:53 hat hch geschrieben:
> Well, a scatterlist culd contain a highmem page, in which case sg_virt
> isn't going to cut it and you need to kmap.  Is this a 32-bit system
> with highmem enabled?
I can confirm it is a 32-bit system with highmem enabled.
