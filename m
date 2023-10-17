Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30417CC521
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbjJQNuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343939AbjJQNuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:50:00 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B47EA;
        Tue, 17 Oct 2023 06:49:58 -0700 (PDT)
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39HBQ7Gv025695;
        Tue, 17 Oct 2023 06:49:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
        message-id:date:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint20171006; bh=Ji9WdZ4rbgIKzlixqsmQJ9wvV55otbijniPDuVT+f
        w8=; b=Jv2F1DPfdkWTCDIEhOIu0uQU7jZoYyaoyCI/2rMwV2Gv/uMKzNFowuQJQ
        eaJTCaHhBFJlsudefALTWodU6+3VScrSRdzDYb6/VWVKwGTq/WdhcCxnUSAWd2xh
        TUuO42DFkwmF4jdeyrPfU2FY2OF0x4X5pfGZ6YCGCwaGGNotvDPCtoHWp7G2RNc5
        TbG/nZ2rZLg/2BrTO7D78dX2s0xrOVcZqzhgalFNniA+sQ3G1PzdDQ69+CL/K4U3
        yQ+20HNVwNkCvTbqdIVA/Z5QTE36r3A89xS76r5AFh5dxpQX/CzmdYW8HO+kaqRQ
        fvgOVwxq8XNQ755mBHRf9smEgM6KA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ts6hthqy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 06:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1X8FSziLPrBJS3UzXGjsNIBuXb4jnnhKd0FJ3ob+X6zugVaiPpsrcwoC0AA85NMpXrpHW0uN8VY51X00i+w8VCZkz0ie5dq7MMpulZdmHivgGgkYkYtS3V2Lwf9xzvhIQqE4BVTabSf/YnsewWqvi1f+KztE4WXIqg3xk5aNmdFPjhtng6SyLd0NcG4bZanH3xMa683LunS13FBy/CMhCuCGZ24uydCTe7TEtXQtlZcmxnlnxosSrxa/oyz1IzKuySZ9P7O1tyWoMCySkL936eeYilN6d/uJHCBg5GPxK0eQIPxKDtXE8mCOJ70/aHatncg9K+3AjSTkZeF5DPz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji9WdZ4rbgIKzlixqsmQJ9wvV55otbijniPDuVT+fw8=;
 b=ADu43PLiVhtokCYcc7aGGI7ARloJ7R0Og/rHNU+Nfndt+jKCEl1bDzi7edvpbCQPggk8/JfdjCarp/jNAKg6t0q1GcDES9gOtLEYXiIdxf6v/qlvECIsbNjHhRoAbeiOEGLtV8Ir+B6H5X06NRxhclZC98eFjykwzLa9C+B5jen4XiHtJ8Pmq9lhHmGDKm1qvzt/JbEgb1IoM6/arNa4NbsbwaDMco+KZUpkNXWlGf6CsPrmp7cY0NWjgmLLsLBrM/+B6dubPyCdSQZQysi1V0Ki4Au/pRnnvhDSJnPcqcVovu3Q8OZaxZICZYzNgpRLrn7m4GA6TebQoclWlgUaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji9WdZ4rbgIKzlixqsmQJ9wvV55otbijniPDuVT+fw8=;
 b=xjlxy76bmhnPLoNAM3ZAIliVjgHoplq0hprjcWDwhqUiuwgQ9rvv+fkp9iCfEsrNvYHjJhyBfM2d8lTKw8hSWM5c0E7xYzhqnBJZ8RnWmDy5D2GbJavJswSZ4RuwYwNwsZsBAGdTXoYjm1BUspDKhFgASHfT46sSg2KvFzxPZgd31vaYz+8/RHPRvQHCphjHV1v1kv2S4B2NkKU1EB8EMHgAFEI68HM9YVh5WDz1GIBqquOfyZ1N5iQfPHy9XtFB2/V3EA1/LrLVmp8AEhuoZze3Y75YFL2TEXmEsOrZOKWY0q7oohYcMawzixjt04iitCMyv5AiNLj2774nusiDQw==
Received: from DM5PR02MB3830.namprd02.prod.outlook.com (2603:10b6:4:b0::29) by
 PH0PR02MB8764.namprd02.prod.outlook.com (2603:10b6:510:f1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Tue, 17 Oct 2023 13:49:53 +0000
Received: from DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::26ba:be45:ee4b:e1ae]) by DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::26ba:be45:ee4b:e1ae%4]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 13:49:52 +0000
Message-ID: <e37ec532-2fea-424e-90f8-77d0997c5eea@nutanix.com>
Date:   Tue, 17 Oct 2023 14:49:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] audit: Send netlink ACK before setting connection in
 auditd_set
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
References: <20230922152749.244197-1-chris.riches@nutanix.com>
 <CAHC9VhTEUybqU3Bv51oLgCWLOjsFQBwzXONwXERPuM1U+vhmFQ@mail.gmail.com>
 <33830e43-00e6-4be1-855e-339d3e74a8bc@nutanix.com>
 <CAHC9VhSbfCKxJM=+mKGCQJNjtL8JuwZ5-mSCLCSvkkUEJywOkQ@mail.gmail.com>
From:   Chris Riches <chris.riches@nutanix.com>
In-Reply-To: <CAHC9VhSbfCKxJM=+mKGCQJNjtL8JuwZ5-mSCLCSvkkUEJywOkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To DM5PR02MB3830.namprd02.prod.outlook.com
 (2603:10b6:4:b0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3830:EE_|PH0PR02MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 489fe865-23c5-4a2d-c27d-08dbcf17f051
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKyZcqwCY0GtSZUc7xNcRhn/aCRo4sj328k71QIKwtSVC5MyxZVpJo1u0aDb6eC0+syAMjaHMO7CDpXBWrQG64qsfquUOg6y7B6D+sHIgWgLkujR8C31GzaHj+DdtwthVSexBjavj6lD22mioW+WPdWV34gvNc/Ynujo9U0pdYWA4wP67vWh/JcM8QAH08hfdMdeZygJL7qYoeWZnnu9d80MHA6FVQ8skRl4o4zI6FJvQuDb/uODw5eky8aF+aFuncsbiQMzMMEtfxMWpPWEt8eZGI4Mjq90rPpNIVOvkb/h4no1ZtrZZTWtS8QtpVc+ElQWggwhHi0BAzwHXwF+x1wXLk1MTjp8mc0Pg2k4I4h9Ae66sVhvz2nstdqU083p5SVS0c3s6XXTgV5srNy+vO0dkrA4Mz3zdMX2H8LLi3paCq3el8Ava/nFRpKqhqyRlYlTnM5Acs9thpSRXuL5h3UxwBPl2NFxpWAOHGgwZ0zfP9eSYNOScPPGg89UmOC1OMfDWurZFf+8VBBtDQvXm8B9tBrynvCz/RGhLLuXiqHux1h3H2uuxNy9yWavwqlVuuM0YNGd+wDtt36X9dWD82Q8RklrRUqZv3+kg9Q39gpH/HZjE0rcEAlp7nh8sLgKQVpFYQhkuj7/ZWWgsqw4kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3830.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(66899024)(316002)(6916009)(66556008)(66476007)(66946007)(26005)(6666004)(478600001)(6506007)(6486002)(6512007)(53546011)(5660300002)(41300700001)(44832011)(86362001)(31696002)(2906002)(83380400001)(4326008)(8676002)(8936002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmMvSWtvSnF0alQzZ1FUR3NTWG5iUWVLMG1RMnhFcUFEL2dGK2lnQWlTQlND?=
 =?utf-8?B?TytMaHdKbTN3V3pIc3ZIRlBCS0ExRVlQSUFOSHNRalZzb3QzMEV3NmtzQUJj?=
 =?utf-8?B?NUFoS0VZeDlBTHF6cjBNYUJrSGp1L0lxWVJ2bVM3RnJYTVJ4c3pRNFRPMkMv?=
 =?utf-8?B?WmMvS0xmUTk3UFN2Q2FxbWJoTEhyTGVGazdJRkpSVEJtRGQ0M3prN3RYY01h?=
 =?utf-8?B?c1lRVzduc0owVUl2VTBsMDNQVmI0cEUvNHpLY1RyQTBkRSszb0FYQzJzU2dZ?=
 =?utf-8?B?bWhneWNETGRLSEIvanBHaDgxNWFjWGZXUWtDUW9zYkI5ek5Eb0tDeTlNem5i?=
 =?utf-8?B?NGVub1AvYi83aHVMNGI3RFpVc2FJaERySzBHWjZXVmRxOFd1eUhLOFZYbG1F?=
 =?utf-8?B?VzRCK1J4MlkzTVU5WXJvdUJCMHZLVmgyK0ZtSzBiZGtYQ2htcGJaVy9qeUxZ?=
 =?utf-8?B?SHNUclAreURycU5hUkJxcStZbUlFTHJ1RUU1VGhCOXYrOFBWNXozb0NFVlNz?=
 =?utf-8?B?TzNwZlkxelNkOVY3VEFhU2RaaDFJSEpNZkhyUVNjUmh3N0VHOXQrdFdPeDg3?=
 =?utf-8?B?RjFsb1k1UGxueTdYTXpTUzVXcy9SQXV3a0RjRlppUzYyVGFFSGxrbmtEZXR6?=
 =?utf-8?B?WlVPRjhkbWZ2RFdic1YwMDRtbGhaWFhRZGJlS0xuamVUWS9FVEIzYXdjdDlz?=
 =?utf-8?B?SW1wMVppYWNTdDlHRG9BZFU2dnpCVGFtNXhWWlJCcFFLZ3BCWVcvN3g2S0JH?=
 =?utf-8?B?bTZqbHk5Vi9QWUxuUzh2c0FpdVBtZCtVWFdCWC8vM1EwZVRqbWJ1emE1QXA2?=
 =?utf-8?B?cndmVk5qS0N0NloraW5SdWdabllHZzlaMVN0dGdPVm5YRWt6bkZWbzl3MUxu?=
 =?utf-8?B?dndnL0N1T1dkL05zS05WakttMWdySTlCYXFJWkNaRTVqc3plc2xOWXZoT3pR?=
 =?utf-8?B?Y0hKK0QyQ28xazZ6ZS9uU1Q4a2czeHR6YmZSenZDVG0vYzdNbzFCRTc1MmZ1?=
 =?utf-8?B?Slh1VDFmc29IOGhtdjBQVEJjWENNbGpXTVRKVGswYzZZNE5zRnppaGRPNkNS?=
 =?utf-8?B?TTVvVW9lN1JZTXY3R2h6K01HOE96RHJKRkZ5eTNMYzNtaEwzaG1IVFNGaHNE?=
 =?utf-8?B?ZS9lMXZrSEhmaU9ZRVVleWJ0RDVxN3ZZdGQrMFk1UGtTa2lCWWRmdVlyTy9I?=
 =?utf-8?B?cEQ2bnBkK2NKTE4rQ200UXhZekNzUnB5L2c4d2tENjlqa3FnemxYZlhHY0V6?=
 =?utf-8?B?bEFyRDJ0S0c1Wlh1SmhoSUhNRFU0bE9QNVViTnRBL0xLeVVhY2U4VjM1NDhv?=
 =?utf-8?B?ZkFmdWIxUFVDdlA1QzA3UWMwOGpJNWN1SDBhL0JIQThTNHN1cUZtZ1YwRFYz?=
 =?utf-8?B?cEhVc0oybzNpdWt4WlZEYjdhKzg1d2w5d2N1bVZGa1VuN3RtVjlsa2pRTEtQ?=
 =?utf-8?B?OFQzQ21DVTIyZExYZldzcUJsVVQwelR5b0t5Ui9CMk5qVWxDRWpacWl3UTNu?=
 =?utf-8?B?bkdEWU1mamNXOWp4ZnVzZHFldGFkenpmMDlWVkFFWlFMampRVzk4aW5BaU1W?=
 =?utf-8?B?bEtjeWo1M0JYUjVwOWR2V29hT1Ryb2JWMS9zMHhXdUN2ZC9pQ0gwWGZZdldY?=
 =?utf-8?B?YnVjSkxMNWRqUCtqUEwvQkwxM0I0NncxbXVLYzRvWWFobms0QkUwWWdpODJQ?=
 =?utf-8?B?b3FRdFlaNDNUYmgyeDBhMG5xOU1sRWZxNHZZYXl5U25Nejg4UTBGT2EvVmdl?=
 =?utf-8?B?cDZiME1KYjZCN2NKa295QjJuRkNFY1FUTXdKeHZ1YkRMa3N4MzdsSVFNYWpH?=
 =?utf-8?B?ZHkvT3ZSWlV2S0JuNkR4WTd4OXorSmRQUnZzb0pEcEdUYWVYM2dpN0lYQ0kz?=
 =?utf-8?B?Sk9FZFUwb1B4T3FsMDU4M2RlcUJEUUp2QklSTnU3SnJtOVhIeGU1bmYxV1dr?=
 =?utf-8?B?YXdSeTk3cWxXbTJWc3gwTSt3QzRYTjhZRS9BTlF0cVpJeEhHUGdrSGViWmRT?=
 =?utf-8?B?V3Q1UEt1UWlQRmZkS21udGJad2FWMk1LUHRkL3JnY3VBSDNvUmFPcVNSZG5q?=
 =?utf-8?B?cXlCWXZTVTBmNVQzVGZxdE52WTNGL0FiY1g5a20ySmlTbTdkK2VpTFY1ZVpU?=
 =?utf-8?B?TTRlZE5FcEFweXBKeXZjTlBIL1hDRjNkVnlLS3MzdWliRm0zTHVINXZORVkw?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489fe865-23c5-4a2d-c27d-08dbcf17f051
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3830.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 13:49:52.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hS61SPW80CYL+wJREuxy84/kb/VPirOx4Yy7khORfW3lV0ntNuyq0cXtrHpgyPTa3pKVQCz+PB/bGmBdhWvj0NjxlkRVXDFTqDJJ1Ajh1ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8764
X-Proofpoint-ORIG-GUID: PL7Iye7c5TR07xooe6xkRAA4RryLInIZ
X-Proofpoint-GUID: PL7Iye7c5TR07xooe6xkRAA4RryLInIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2023 21:16, Paul Moore wrote:

 > Thanks for trimming the email in your reply, however, it is helpful to
 > preserve those "On Mon, Oct ..." headers for those emails which you
 > include in your reply, it helps keep things straight when reading the
 > email.  Not a big deal, just something to keep in mind for next time.

Thanks for the pointer - I'm new to these mailing lists so appreciate
the advice.


 > I should have been more clear, that's what just a quick hack that I
 > cut-n-pasted into the email body, whitespace damage was a given.
 > Typically if I include a patch with the qualification that it is
 > untested, you can expect problems :) but I'll try to make the pitfalls
 > more explicit in the future.

Gotcha.


 >> While typing it out manually, I noticed that
 >> the condition for sending the ACK isn't correct - if NLM_F_ACK is 0 to
 >> begin with, then ack will be false to begin with, and so no ACK will be
 >> sent even if there is an error.
 >
 > Good point.  I'll just casually remind you that I did say "untested" ;)
 >
 > I believe the following should work as intended (untested, 
cut-n-paste, etc.):
 > .....

I think ack must be set to NLM_F_ACK initially - otherwise auditd_set
will always send the fast-tracked ACK even if the caller did not
request one. The following is a concrete version of what I roughly
suggested in the last email - is there a specific problem you see with
the (ack || err) condition?

@@ -1538,9 +1551,10 @@ static int audit_receive_msg(struct sk_buff *skb, 
struct
nlmsghdr *nlh)
  * Parse the provided skb and deal with any messages that may be present,
  * malformed skbs are discarded.
  */
-static void audit_receive(struct sk_buff  *skb)
+static void audit_receive(struct sk_buff *skb)
  {
      struct nlmsghdr *nlh;
+    bool ack;
      /*
       * len MUST be signed for nlmsg_next to be able to dec it below 0
       * if the nlmsg_len was not aligned
@@ -1553,9 +1567,13 @@ static void audit_receive(struct sk_buff *skb)

      audit_ctl_lock();
      while (nlmsg_ok(nlh, len)) {
-        err = audit_receive_msg(skb, nlh);
-        /* if err or if this message says it wants a response */
-        if (err || (nlh->nlmsg_flags & NLM_F_ACK))
+        ack = nlh->nlmsg_flags & NLM_F_ACK;
+        err = audit_receive_msg(skb, nlh, &ack);
+
+        /* Send an ack if @ack is still true after audit_receive_msg
+         * potentially cleared it, or if there was an error. */
+        if (ack || err)
              netlink_ack(skb, nlh, err, NULL);


 > I'm not sure I can recall everything from when I was thinking about
 > this previously (that was about a week ago), but my quick thoughts
 > right now are that you would need a lot more information and/or
 > handshakes between the kernel and the daemon.
 >
 > Unfortunately, both the current audit design and implementation is
 > seriously flawed in a number of areas.  One of these areas is the fact
 > that data and control messages are sent using the same data flow.

Makes sense. The question of why there isn't a separate control socket
was one of the first we asked while looking into this.


 > The issue isn't so much about the queues overflowing inside the
 > kernel, it's about being able to schedule the audit daemon and/or
 > kernel thread to service the flood of connection
 > disconnects/reconnects coming from the reproducer.

Right, makes sense.


 > The old audit mailing list, where the userspace development is still
 > discussed, can be found here:
 > ...

Thanks. I'll post there too.


- Chris
