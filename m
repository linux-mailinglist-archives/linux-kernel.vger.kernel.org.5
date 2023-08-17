Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274F577F637
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350743AbjHQMRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350772AbjHQMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:16:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334242D5F;
        Thu, 17 Aug 2023 05:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrd6U6Givqyr6C/ug5YY0VQeefe2OS3ZW3qsRl70G8Vam0XrkoWiigjItNN2S0IHtWrs3TJ0aI49Fp6JqVe+ntFsF4z8SATXfjar3sxJOnxCs+3XX56hOxesbgigzuIBikFRyCButvY+UE37dtRanzdI0N+z4XacQo9/JKvoXng265OqWwakQ7zIxunmsx2sqHdyntj+GpNiianTI8oJIXIQmsuRu6DAs5yObHqnn4XHLXQk0QO/mmQ1wY0vkFzBVT7AuzRnt8U9+Nc4U2aCMHFE+2ARs6niIhi1xehDdO7ITiHh39lSOkDtDw2hyaXEKSXsG9k2kAucO+nk3xn+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtHbHt9JyY/i6f1W0yKBMjivOZGt424xVV3WcfwWq54=;
 b=YxHu6CLkEQgiLsCcEyZBGMbJBrF7nHH8sPJGaUAD6K8Pr2y571ydxm5+mQISxtNo/5+1eO/b2BrWplYX0A3JIQlBmKdrbTaItdaKnilMQEW1H2JgF7SY7aE+v6KuyJ8jw+8dE9owcBQUqZ9XI+jzUgwYqTZ+vAxZOu/Fm/r1wwkkqPFCLqbU3ujTMiapTnfMTNPJ7WrmYLG03yOIsWB7/UOZ6c++OQWA/MmxqBdelg7qWigYO0gCZob7aJq59bYKryECcCcFihJ3ZCihnYx4AvO4CAafxVYNFdLu/iX8XEOrU5RrX1GRU+n6a2aNkKzcJd7+wfJczVRn6EOWZj8AKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtHbHt9JyY/i6f1W0yKBMjivOZGt424xVV3WcfwWq54=;
 b=mWryVV3+UeMTawaIQQx9jqJi1Qez5XRv3gYiea39w1/spt+vASiBUdIuoS7P1Uk9Lg2g7gKQzMEG1fkw5t2saKcQaf9NdbRN6k+YHbi6xbQJc4lh4TLApX+SnlhjKKUksmDUmtcMtbtAXFXJgSQYTPBU9AdvmjVPzUvGbGvJ9xVuDlxtqnKBHSZDCIck4STQUy4Bu8Xvd3ii4/r5tizoNSiYTasweo73W74JEwpfKGByalIu2tETvmG7PpOzancb8gbNz7TZeFnyXxHb49HThZaE93iylYE0hAR2UD7F2hHaJ/B7Y7YCf5kJ+Z+8nNqSEze26jejcBeH6HCZswkFNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 12:16:29 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::51fc:914:29f5:a420]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::51fc:914:29f5:a420%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 12:16:29 +0000
Message-ID: <5919c39c-1ee4-262b-4ba1-f0e58088611d@suse.com>
Date:   Thu, 17 Aug 2023 14:16:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Write in
 usb_anchor_suspend_wakeups
To:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+d6b0b0ea0781c14b2ecf@syzkaller.appspotmail.com>,
        Oliver Neukum <oneukum@suse.com>
Cc:     arnd@arndb.de, christian.brauner@ubuntu.com,
        gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mpe@ellerman.id.au, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com, web@syzkaller.appspotmail.com
References: <0000000000007c27e105faa4aa99@google.com>
 <00000000000014678c0602b6c643@google.com>
 <1134d446-3189-4f2d-81b4-10142e751320@rowland.harvard.edu>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <1134d446-3189-4f2d-81b4-10142e751320@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PAWPR04MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: 28369509-8d81-4e01-6210-08db9f1bc925
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3hqYi9MsbZiDAl3m5HhrnQbzqcjyqtHqAeey+B9B0aXtYWfykQc/sOlv5etVAkgebE+O0mo9VhxcpcN8P6wP8X/iJr1YF2g+eKerKQv0Ls/AA2yL0aWvjPfH166Qmd4Iw4mvWujgHZfKxD44UONMNxIXQrBxEDkAS9PvS+ryWfy19HQJN3QXPq0DvqVPoaYYjTA/11ndA/W6b3/+WhPHK3NNdNcn6cGk5iQsKefd3hSKq+yc5aWPg+4M4RmcPAYO1/CUzNa8PzFKvb1/fFe62ZXlLw9pErHDt49x/jGvk+jsMLZnMT0ZwG+FXRlaYuLUQcOzXPFGZZQi7oOGDz3htfx0HhIqdWz4LdERwWLyuJKWkphm+9GyoaT+mR1P0+Sl4J+wWdaSkfKvLogbQx67pUuZLzvTn3C9BoaWmTbqalxVwIGBpQfHPfYah84xMc0lKVwpjifGspVGqWa9kzP5albJK9PXMhiF0/8acn24Zv2DqkgfpHt4r2neBQsnF4+VY/8/OzfPrW4XJVnokNkmSmMYPhyMOOUaBXte6JYN2wqNVJLBnrm78sHAmm3ldsLUc2DDfc1dP2+jGjn+yg9V16M/dRgwBOG6rmtrfv4VGXCUZNfiYQjxPOr/Y2O5VhDmxNs23ZYv9SUJbOj6oBbIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(316002)(110136005)(66946007)(66476007)(66556008)(31686004)(5660300002)(41300700001)(38100700002)(4326008)(8936002)(8676002)(2906002)(31696002)(4744005)(478600001)(7416002)(86362001)(53546011)(6512007)(6486002)(6506007)(36756003)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnVvRENVYjh6Um9ENE81QVBmZCtaTVNYakIzMTA4N2NzTXoxYWtZbm1EN2lx?=
 =?utf-8?B?OTk5SUNIcWMwTHBkVytjSUkvVVNzVHF5SXdRWjl6KzA5MkNwRmEyZ1c3Zm1W?=
 =?utf-8?B?NlRuM0M2dFFuTjRXRDhWNVlvQXBJMDFEMWxUbUtaQmU0QWFKaUpjaG9ubCs3?=
 =?utf-8?B?N25vZzQ3N29DU1FZaWI4Vm9SbTBrL2o2MklmUm5wU2QwamxDSElGcXBwY1FE?=
 =?utf-8?B?TTFFUU1qVzg4T29seFd2NklZaHVkNzNRYWdyTnpINFQzK2NBUzQzMWRpYUxt?=
 =?utf-8?B?WXdUV2tJRHF0MGhwUDBQWmtGbFRzaVBmbk5BQlJZVDFLTkJHRGlSNm1ZYVZJ?=
 =?utf-8?B?ZkRGaklOYXBEYjBZTHJyMEtqdHVDZ2NuQlpjbUdNelcxVks1ZGpTZTM2Nnc5?=
 =?utf-8?B?MVdsR1p1Rk9ubGtLZHlYTEN4c2lKeEkrbkJBMEluL1NtTWw2bDBWNmpGZGtJ?=
 =?utf-8?B?OXIyN1I5K3dWQmNHZlk5TlFQTjg5Ylc3MFkwYTU3WVgzVm9OaUJlUHlibW04?=
 =?utf-8?B?ZDRhRy90N1lITFkyWGVKRnBPa2hjaFhkTVgvTzh4alE4aVYyU3dONFZULzVw?=
 =?utf-8?B?dFBTMkJNZ1FGdmw0cHBOZ1haUGZuMHN2TVBWcmkvaXNENDR2YTQ5bjJGZGFx?=
 =?utf-8?B?RXVaSHdFcnFVcjBjUzdrUzZJbHFjaVVQZDhSRUtsZlVZY1B3S3BLbVRUbnQy?=
 =?utf-8?B?eGFlZXluaUZaZ1lJdW9ubHdrOHlTMVFId2pUTndNNTlnOGdGYTh0c0ZWUWVH?=
 =?utf-8?B?NXVHVk1GaGUyRE1PNWV4VmlaV25yNlFiM05KMWwyY01YNTYxTXhQOVR5QSs4?=
 =?utf-8?B?aE1Rb0tSWEhYcWR1VGxZYkhZOThRTi9xZ3hRdmFPNFB0U1d2TVJtZTZEdk5G?=
 =?utf-8?B?ZHF6cEFFMm43eThYM2EzbmRCSUcrOEx2S2d3NlhsdVFNRHZaWVA0SExnRWo2?=
 =?utf-8?B?NmlUNWszQWErZm9WdFdEMXFlbyswb0xUQnlXUDRyUVhKWUUybHZ4dnQ3azFP?=
 =?utf-8?B?RW9VMjZXQ1d3RXhtNlVtYXVuKzdWQTFGeHppSVNTWHpMaWU3YVNqdE1zUjdG?=
 =?utf-8?B?L2hLbE1uMGI1RzdGVG1VNWt5VWRHejIvY1BOTEE1eXZUcDdkaUpYOGdkM24y?=
 =?utf-8?B?UHFxVlZ6RUJ3eVltaVg5K244TmdrNzVqU09DcnNrWFg1aDNQVEtmdXRFeHFE?=
 =?utf-8?B?d080cUc2YkRhNUMvSWxHTTVBaXQ1TTM4MkJhMG1kbDFaVHFyMStWT29xWlpQ?=
 =?utf-8?B?d21SUHF6UjN2dk8yQmhrUkxTQnVhNjhZa0hMb09abFFjZWlQWFl0VUtwelFi?=
 =?utf-8?B?MERNNEExbUhLbkR1UUQ1V21aWE4yai9tL1dmKzY0RHVLc2U0aHZnY1pKQTB0?=
 =?utf-8?B?WXovMmN5M2lJb3dOeFFpK3FRdXd5dXJjeGo0K3JqZTB0dWxLTitSaFFHVGVH?=
 =?utf-8?B?SHRxMXpHVVR0WjVyZkJRTGY2RngwbTNpZnlRS25MbW1HV3FDVlJNbzJxb2hJ?=
 =?utf-8?B?d1QrTHVTSGlWSm5EVTdKcFZDVkFucHEyeEdYY1g0dFg1MXFFL1pTTEtBYTdL?=
 =?utf-8?B?SDdsZDFNTm5pRHlJUDNNQnBLZ3BVTmxGUFhNVFpQRTUyMDNNQktFeWhYTzkz?=
 =?utf-8?B?dE5NZFY3Qng0Y3dvNm1aa1NtU09KQUZkZnlLUmZxT0JJam5DYUpzdG1ocUt3?=
 =?utf-8?B?KytBbzU4c0lhUGlzdmJOeUgxMkdEKzNlRWFkQTAzMjN5eDN1S3pudDNQUU9N?=
 =?utf-8?B?ZzQrNUZMVzRVbUt4VWNhNFZCTGk4OXVZQnZOTDE4eW1Da0Q4YlZYeXBLKzdC?=
 =?utf-8?B?ODdNdStvZWwvS25pdnd0Zm81cVVqb3c0K0pJSkVZRnFIM2hoRUNrZTd1VjM3?=
 =?utf-8?B?dllMM1pOYXltaXVNS2tOMnZOdncrOFBLaDljVThhUXZSVjBmeDlKUVZSbU5Y?=
 =?utf-8?B?a1dWUE5JWnF6OHJYM2xlNWhwUS9jMWhYV3E2VHVzcWNpeGRTbm1VeWRiYkZS?=
 =?utf-8?B?Zjd6R1EwV3A3MlY5TTRtOTBzUGFsa2J6UWk2anpRVTFBMUhsVXlVN2FreWxt?=
 =?utf-8?B?VEtvUkN1bjlUNXFEcG40RENvRnR3emdoUXQrY1htSDZ5UXFaVjlIL2hzc2FB?=
 =?utf-8?B?Z25IclNmVVdFdnNodE5NNE41ZngrMjgvK0lOUldadXkzeHNzQTR3eDJLd2RB?=
 =?utf-8?Q?/7OhTMIbtEGGzOKIA+q6RlYo6p4dwZnJricZyVHKkGuV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28369509-8d81-4e01-6210-08db9f1bc925
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 12:16:29.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9t3Axjzfy3h9CLSH+HJiQT6CLJCNcpyoDKhzwx/K75eubkn+R7rrB9cQSiKjQefzGM0oSA0DnGXGEHZot/3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.23 17:56, Alan Stern wrote:
Hi,
  
> The real problem seems to be some sort of race in usbtmc and the core
> between URBs being added to an anchor, file I/O being stopped, and URBs
> being killed or scuttled when the file is flushed.

just to make sure, you think it is failing here:

usb_anchor_resume_wakeups(anchor);

because we cannot guarantee that the anchor pointer
is still valid, unless we refcount anchors, which would
make embedding them impossible?

	Regards
		Oliver
