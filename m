Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733A37C87E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjJMOcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJMOcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:32:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2098.outbound.protection.outlook.com [40.107.113.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C5395
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIQiuTj6wIkZEZ57pHWaknTC8bys7rhdwWa9209a5PxiuqMgTDrdeE4cd8/34EkV5VBFfZQ/A1ZhPk/pGpazrGJWU58Ko4WRGP2+OyVjol5E0FRKgQ7DWYaTJIlD+7CjLq1d60j3hmOPBLJMlWXgCWMryNLB+UQD5YlgyQAKtD2hhi8pyCzB8IW4HAfAPP+hTcwj2jkbiOZh+Xr7iUwAoo35i7G2mb/k5Yw7bqRSMJiFs4J/jIHG1NOLzUjPqUyK5/IvbS0p2na43VjwdIQrXyIjTxWHujG2Ei9E+qYL4AarimiYlhdmsIkozPdOpiEAhAm+VE7A3z5GN4/ZAWtEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1t11zEnnCdJ2ZqFzHJACouOo22Srgo7s/LI3r0PrB4=;
 b=D/swLNEhWbCMsBVy4MP575qk60z7LONxGMDsdFUl0V9yyKsbrzpVtu7E+9hovk3G9PML9KRYR3nVl1DkPY1U7rdy2/J7wSQ7u6M2cLEJYORP+y4hFsSZ1h+cgJ5mXyWaeuCHBs4yN5R5s5WugMjyZUZiJNkytgQi53jDgcS18ZNmikyCEqbp5xrUNMRolSgcsFG7UvoIEexPUYZ48EVbAt+yAMOXpvtgmCZi73mO0AWJKGJ8z456quLu9q0Mn5x/JaIDrm33W9ldUKTS2MGcjJkju+GZdU1Qt/qa+DWLRp9HDFiwpp8YdHF0rH7pqXtS7Ell0T+I3ryKfDVk19oqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1t11zEnnCdJ2ZqFzHJACouOo22Srgo7s/LI3r0PrB4=;
 b=Ys2f0e44fnY2TLWUGvcUzxGnhYYMWSBOPCUN9jX7OJ0bG1n6Tq8xImL4pTr6WP0H83xeXd8aa75bVIXf1ElRL1ga5lsp0gcs+7aci13/QPn56xvuqbei28poB1DRXslh2kwNzGCw0jOL7STowRdfbfZMljGWPIn/wTUgAI8CVWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::5) by
 TY3P286MB2657.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.17; Fri, 13 Oct 2023 14:32:35 +0000
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc]) by TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc%7]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 14:32:35 +0000
Date:   Fri, 13 Oct 2023 22:32:28 +0800
From:   Zenithal <i@zenithal.me>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] linux-next boot error: KASAN: slab-out-of-bounds
 Write in vhci_setup
Message-ID: <ZSlU/Pc5I0f4UT7/@Sun>
References: <0000000000007634c1060793197c@google.com>
 <ZSklqKDnv9OAGMC3@Sun>
 <CANp29Y6DfZWQqOiziU5ysBjRfvP-ZgRfdhuf4RF6MT5Y+J1k-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y6DfZWQqOiziU5ysBjRfvP-ZgRfdhuf4RF6MT5Y+J1k-Q@mail.gmail.com>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: BYAPR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::27) To TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:de::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1406:EE_|TY3P286MB2657:EE_
X-MS-Office365-Filtering-Correlation-Id: dc006923-979f-4b49-e7aa-08dbcbf93dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wsd4enqkqtw34DD/VoN4dAcFVs6cq2ntz2JPXl/f/TNPqXx25G12biK5VQmu7VELA66XDgsu3UPWZOsx67oOfDSCfsTyq4TsXaeWmRTZo7P47HzCYx/7JARYa32U0DEZRiMtS+RVI8czMtS7XspjAxTSO/CWD9QuuAUSzewHuHg+FokuXyJA0QYIBKN4hiGScy6UxEzVtVFzb0IoxBv53wQeuEDmEzDyF3FkiNy9dk5chUF+mUGMuc14Tdqo6ip/2+fycxQiQo+jWFkBl0MUygw3xUyR9F57FujVaumg+LgFI+xnfgrO3fNgZfmRhq/Zj4MHsVfi+jSjzaYznhuLKBnK9BDjk1DzWBa1LMcZGZE5ZRzgb9/mUJBJfiO9MeYYXzPd1MYu6ycResDYmRWh7xrHmwHHtm6FU+hlV6GS9ypd9O6iU1yV8FinG5AmHlvUxoI1mCz7WorEO/XMykq1ivUsG4AYQ08Ig4CBspfL5xZ0t+Vl0bVFpxUq0MqW3E3VBOtTPBOaY+/yXOZ367xEcIgV7wvxeQF64XdBNzq45QX7c243NzePV/6okFZDsZ0H/lzoWXwaCNby62Y+vJ05++TAvp5DdpYemKjPaxnq6VE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(39830400003)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6916009)(786003)(66946007)(66476007)(66556008)(4326008)(8936002)(41320700001)(8676002)(316002)(4744005)(9686003)(6512007)(53546011)(6666004)(6506007)(33716001)(86362001)(2906002)(38100700002)(478600001)(5660300002)(6486002)(966005)(41300700001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG5weXJWLzU5NnJUdGZLOVRHRVZGdDljazlMTXNVYm8xMmdkZWZaaDMrQ3dn?=
 =?utf-8?B?ZWR5S1JKSXBvU3ppdTJmRVlvWXRhckpBTnZmSi9xWWtHcS9UdGZFR05nNi9u?=
 =?utf-8?B?dVlqOEl0SllseHVhbzV2MXJJRUNXY3pPd0dqQ3NKcmdhOXVCRlVMNnN6ZGhJ?=
 =?utf-8?B?WStXUDFaOXFPNlNwbVlFUHkvODdqTnczTGZPS3piWjdWTVFIeStONXIzTmEz?=
 =?utf-8?B?a1JJRUd3Z3NnNDMxZ1pzTXlrQytzakxjUGZLRWNGd0MrWmZMRThDa2JnaUwv?=
 =?utf-8?B?ZUIvckpFek5ua2c3OENhbFBMZ0lKUmNWMUFmNmQraThhNlBuS3lGNzFGTDNj?=
 =?utf-8?B?TTVDR2ZCTHNxWmFuS1ZXbFNpUlA1cWx2U29MUzYycFNMOFJTSU5SWDVCOVJt?=
 =?utf-8?B?SlgvN09tc3lmbDJMMUxGaGhHa1p2UzdnU01CTmNIdVUyMFpuZ0Z6TkthYUZi?=
 =?utf-8?B?TndqbXVEdlpheGFqSTB3K00rYmhUckRITmFSbElxY2ExUnd4aG1sZ2R0dHpt?=
 =?utf-8?B?czJKVU9VdUNudVF2MWlFQTg1MXBDWUxza2JFcVNPRFBTV2xXVjNuSWZHMGhE?=
 =?utf-8?B?WnlKbkl5VzN0dVMyR1l6UjFwU3ovZU5lNFBnN1VwYmVxZWtoS3Fva2czTCtL?=
 =?utf-8?B?d2pNVWNEamRpS1o0ZjdabER5TUZVUWxiQXNnbitWOUlKaHZCcUs1ME90aTMy?=
 =?utf-8?B?VWtKMzFKQjlhdTUrYmxGU2NKZjgzZTd1TGI2dzZ1UVh6OHRxTVFTYmJ0TFRP?=
 =?utf-8?B?cXNSMXViSnhEcFppcmMybk05S3BsMzdlVXh1NjhkcXZwZVduMDBRQXVVOVlo?=
 =?utf-8?B?QmY3cS9VRkhlM3I5cjJHbzRkSDNjUjFLd2lra0RQaGRPbUFuaXIwdjBTcGpl?=
 =?utf-8?B?a3d3MFBUZ1V3QURwWkZFMHI5UytUNi8yblFJNDZpOERTZDZHcnlrZHRNekkr?=
 =?utf-8?B?Ykgza0s0L3YxZmJXTHhDZy9PWU5VR3lBZm1kb25EQUsxYmdxaGJvakIrbXd3?=
 =?utf-8?B?d0RDallrL1lTVnF5dmpLK0FuRmF3ZDladGFBcjQ2WjJ3OGNUcituZkRLSXJj?=
 =?utf-8?B?c2lDeWxsNFljakhQbXZSTEZZc1d4QW1jNTJuNFYrQ2pySGF3UG81Q2wxM0Ji?=
 =?utf-8?B?NlVDSS81bDFnUS9SUm5VYkp0Z0lQR0tFQW9jZ3M4VWloVytSUTZtR1ZXMWJ2?=
 =?utf-8?B?bHRtaXJQMlYxeWprSXFPYlo5cTgzOFdmdHFKQU9nMnhiWDZmNkZJZlpmMFcx?=
 =?utf-8?B?S1ByOTRLMmljb1EyVDlBQXlBeGhtdjBmYlFwbm9QTnF1eHd5U1BKalVSQWpR?=
 =?utf-8?B?clB1OURDdjRjcW5GcmVDZk9JaDFDNEEyYUNFRTV0MTM3L1JIUDRRQ2JFS0xv?=
 =?utf-8?B?OSsyU0c4cEp1Z0g0cEdLN0ZHQjBncXNLUjNGYWh0ZVRQREhFT0NIQ1pTczBa?=
 =?utf-8?B?QWZWeTRzNTdLLy9OMk5oa1c1aW1QMjFmSzEvSXFSM2lmM2tYTzB4aFhQMDd1?=
 =?utf-8?B?TUtsL1ZRM1FuWUpvZG5ZQ3F3SEMrcTI3eS8xTksxWGVha1lCYzFzdmRZaGtY?=
 =?utf-8?B?Tmg1cDVTbW9mOGFqc0ZKTGhqYW9TN3VZV2pBU05CaHlLTDB4d3I2dHdGY0tS?=
 =?utf-8?B?QWdiT1RzUTV3Nzd3Vk45TEFhT0JtVDByMVZSeUtYa2w0YVB3MytjcWJaUlBn?=
 =?utf-8?B?cHMwbHoyL2VwWU1NNHVTUFVqU2p4d0JBb0Z4NDJNUytNWk9PenVTZFlPQWRq?=
 =?utf-8?B?Y3pjZkdKZm1pYXdSbERaOUVGNzlhSHl6c3EreG1IVXFBQkJIVS84N1F3RE8y?=
 =?utf-8?B?aDMrTHUzNGp5aGRTY3FsbExSRXd3NXVSOHR5eEQxZEh1SzR6Sk40SmFHSTNq?=
 =?utf-8?B?UHBNSDBxVEtGeTVmc3FVYUNmQWtIbkV6V0F5WFdpSmVjL1dvem9uWExGa1Y2?=
 =?utf-8?B?NDFoc0N5ZW94Qk01VUdVTzZyZlF5YkxtOWdweDdCM0RFWGtUL1htOEdnUWhN?=
 =?utf-8?B?Yit6OGlId3A3a0Z2aUlTdUtoL3d4Z01DK2VSZWQvWm9jaFRHem1SbGd6eVlv?=
 =?utf-8?B?dUI5WTF5aHg3NDhJSjlRSlJhbE5uWnRFcmdpQ1QyMzBzNHNyUGxQTi82WWNL?=
 =?utf-8?Q?AdB94p/Y7t+N+hq6WuKVSNN6j?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: dc006923-979f-4b49-e7aa-08dbcbf93dec
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 14:32:35.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1RCOIfiMt1DUgydvCsxdHYSHLAyy4znB6dNRiE8Sfi7xSrTds9+6YvmQ2v15yNe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2657
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 03:42:23PM +0200, Aleksandr Nogikh wrote:
> On Fri, Oct 13, 2023 at 1:11 PM Zenithal <i@zenithal.me> wrote:
> >
> > #syz test: git@github.com:ZenithalHourlyRate/linux.git usbip-fix-wrong-platform-data
> >
> 
> FWIW you'd better pass https://github.com/ZenithalHourlyRate/linux.git
> in there instead of git@github.com:ZenithalHourlyRate/linux.git.

Thanks!

done in https://lore.kernel.org/linux-usb/ZSknFd3ywz6e+wNg@Sun/
