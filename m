Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AB771DA5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjHGJ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjHGJ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:57:13 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14611A4;
        Mon,  7 Aug 2023 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1691402231;
  x=1722938231;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cyolt6dTYY8zLucGvmzt4zp0COmDiU/d9uiS5NaMA+g=;
  b=aKNSw+u/M/gWnUnpJNDy7T93kMF57yufxI64b2nAzMWhYj/7GEyWcSzD
   OAxOM3dNy5ylSNS1oTecjSaRQQMFr92jRni0rtIwEqXvirHzmSE30B+Mx
   ZmV8okTeVC7JagmyJQ8YVx6zRtnpkKp0qBsA6DYNLSXaYnx61vgL1pChc
   YKPSHmJ5e5nqkzhJboaW3N6NIvAYPDi74khM1TAB716caynKlSa2hi/ad
   BLWxHwzcZjzo7J2zwc73/7lfSdP2T9Wk6MxAjpQXsuysfemcgr+/sEyHX
   8MH9DOiui/AeDjVUECrlR6cLfIpKEsFb7HUMnSWvOA+Wv6Vm2mwczSf14
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXLkbfRlU5bMPWkLPOSvmzJNW+M5RxqS+gVI/ZT2ldEoxo8mS3fWueUy8CuScGlX99jI6qMqcnCZq2Rh3NJ+YesvkMSw+nrxqarrmQFJY6Hu18XZuBfZnEQI0leV5TmrpgA2P60jV0goipL8uJBqy8NkMyI0Y28HqgIyLkQn4swfqh3OkdUcQVnXTY/LNU1i8FcK981vKK+YNh5guRl7wiNAwbMJ1NFQuXiyjuhcyfF4h1JMl7hP9ejhIU4WIWA9RU4FVrTfJ74QNj5yl/ECt6FmBzW6IziJ92uZc1xM50RLCY7x3wpAWNG9FX4HHa7tfkGkPAkzu2pqW7DYoOzy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyolt6dTYY8zLucGvmzt4zp0COmDiU/d9uiS5NaMA+g=;
 b=FVYFdqS8RnWCqPEaGw69L1djVeKTZ0TDTXGPzOLWDn0FBIoG8rUgd9RdgIjm+xadoUTt63KJ7KXF5XhHx/nyzFEvGW1HqaazrmyQpeeSqx7HG19u1TifSlK25aFVkfdFvx7O/ZRqCf2bnh+w/FhaWmqVF6UGHYc1zZakpaZ7o0b6pWuilSmL0BC6xvfMN6LbIld+PkXxIQbrscfnCD7GbaRTLaXXASO44PCSE5b8+IZmvPdz5GrOPXI4o8JEFkW8GJnAif/qKeO2jhWxVNqQiL45ngutWoVhQce7UFgMo/NlwxyvMvoXbOmWk31UlrsejZC8bxhWBU/9iT4jOyFpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyolt6dTYY8zLucGvmzt4zp0COmDiU/d9uiS5NaMA+g=;
 b=b5Zck0QPmi1xbOZE2ImH9BFtUqsk4q+LuGWB5+CesMUtQ8DlgQzd4S2bIqhJxAxFBHShfxueonRw4X8s2qhatcz+esOAQW7PG8MfwkTIrbjbxlFUlM7OuSkkzvZSpUPRZVdrHr1JWMi8NEUDZgcJyWeo0o0Qy+dLRyctWbf4cTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <1dbc24c4-b057-0e71-432a-a7d0ce2df2dc@axis.com>
Date:   Mon, 7 Aug 2023 11:57:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tty: serial: samsung: Set missing PM ops for hibernation
 support
Content-Language: en-GB, sv-SE
To:     Andi Shyti <andi.shyti@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
References: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
 <20230805213824.ol7sr3b52rwrsfs6@intel.intel>
From:   Anton Eliasson <anton.eliasson@axis.com>
In-Reply-To: <20230805213824.ol7sr3b52rwrsfs6@intel.intel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::35) To AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR02MB10348:EE_|PR3PR02MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 181de44b-1788-46c8-f2fc-08db972ca839
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTu2lWUIKaMDboHgwzx38i4vwCNsvL7SATl6AqKPokusjRs5q3QDXwRqsUyBQ71cyR6PgqsAEIJmHFvi5hFOIj+Texjx2ea2bNztFkuoY5V9Fzh+IF2KXXmQoJNMzVb8FU90f9koy1xyg3mPjxgppp0/hFVs3lbVmm5dSc/n8NKRDb2R/VAmVsp4fOTVXRMqq+S+Y5DcPMWmQ6JriF7766wil888v5WrF4Pyg5AGJ2yrfmgpZPBFU2MubaIJjoTGBgaKMRD8EBw0hy8BcqhOAULJIs9T0jkiS1WOK6eBckPisTZX2h0ZQHdd3koNTBcuOSIHCa6sD650OWhgLMfGgD4LktReRh9Gw6rMDGZ/NkuA3gJl1JGXO6jv4QZHouN6EKOe0eFdb/FrAOMK39Ifd3ufC5scuj5mbK1WdX4u7uWI8bTcPP5wbkC9u/58GQr7cl4OCDt6phHP5e9MqWbUNPm6vMOC9G+kuIbvme5CQ8B1MVcDkcGFPiTq8aITlIf8Dzp58+ji3x5A8KDy7CoKE4183p5VJ8mcNG92vkBjP921JgcUvIAqdRLj8qVaJginvMnnrU7g3vAQcpfkYCEmMUACsxtD+/1nKl/dE68YpRhg3ig4D5THqDWRLfSQLimKgmd9zLdNxi4SJqEI/1LqZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB10348.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(1800799003)(186006)(2616005)(6486002)(6512007)(478600001)(86362001)(31696002)(26005)(36756003)(107886003)(6506007)(41300700001)(316002)(4744005)(8936002)(5660300002)(44832011)(8676002)(54906003)(4326008)(2906002)(6916009)(66946007)(66556008)(66476007)(38100700002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDkrbzJ5TEdZMXhZVHRHSkY0dXhuYVphSmtFTjVIamxybHd6bXRlc0NUMXlL?=
 =?utf-8?B?M2xnQythc3JrL0JEYkNxbkM0UEtPdFBFS0VLOHdmRHU4Q3o3OGRBNGVlQ0Vn?=
 =?utf-8?B?Rms3UWpWcFRzNjRLUklYc2diYm5uNm1BUjhKUkx1Y0hlN1ZqckNqV1YyNUpN?=
 =?utf-8?B?TUJoeEZISEdqM3BBZlV4SUFmMGphM1NGVzFlZU1tazArV2tHSnF6SlhZczhV?=
 =?utf-8?B?NmRMWmtFcElGTkNhbi94aHh3eTMyREUvSVFBQmdBSW9wbmpSdVVrMC9OcURz?=
 =?utf-8?B?ZkhGYXM5bEphRkV0ekhjNGdnd0s3b3dvS0ZsY2VWWWlHWFFUKzNmT0lycFRK?=
 =?utf-8?B?Sm9lQ2hOQjV6MXBOUHMrMjU4Yis4bG1ZTkNqMTdDTFVDSzdJNEJiYVRpRVlu?=
 =?utf-8?B?NGkraCtHanNFdmRPNzJIM3g0MDROOUZBejk1RE1Lc05iNE1pSTI1TCtkZWJl?=
 =?utf-8?B?Tmx0QU1KOXE2QjlPazdUNzB0WllPdUplSkx3d1VHbGJ0NzNWeHNSSUIvemZl?=
 =?utf-8?B?VVpQeXkyYVFpYURwdHAxVWsrVk1hV3lOM1VNUWV2Umg1WTBpcVRIcVdRWk40?=
 =?utf-8?B?bzF0T3EzMGZ5Z0RVSFEwSTdWMGI0YVlCUkhxYTI0OEJWVCs1OFNBTFJUVWlW?=
 =?utf-8?B?cXpWd0ZkNHlLd094RitXUGQyTEd3L2ZrM2EvamsvZ0VHRE5va1QxQXBYbS81?=
 =?utf-8?B?dVVFSXdydVB3blF3bklDdTF2dnorQjdhZHJnVDZjRDRxdXZWS2JtSFp4dExC?=
 =?utf-8?B?bkR6VFBXazI4ZFY0WGoyS1hHa0ljSFlrbFR6ZkpiRGMzS2VwSmc1MmFRaG5o?=
 =?utf-8?B?YmQvVUhmUUs3L0lkTzI4RDN0d0E2Q1Vmb1hINU5jQWZoWk02K0JaNUlXdFkz?=
 =?utf-8?B?ZDlkdFkrZmUyKzVQajl0dmhzejNJOXhtK3M1TlNuZzNNdkdJdDFsWHovUUFk?=
 =?utf-8?B?MlhldFRhdzBDVW9uNnRmREZNd01uNWZUKzU5VUwrczM0dVRVclVldDRrTzZI?=
 =?utf-8?B?bTk2MFhpUXZEWm96ejB4NGdLOGV0U2RhZFhFNEZtQituaVkxY3lSSzZLYXJH?=
 =?utf-8?B?Y3drMkpqOGFTaXY0Rml1dEJuNmhlakMxVjF1VEJyRUxyUFNXQS9KVmlveU0r?=
 =?utf-8?B?UHhzVmIxNnVIRDFUbCtuZXR5UGM3YitsN3h4VkhLVUtkSGhSRDVxZnFlL1Bx?=
 =?utf-8?B?WnVCaVdnK2NsL0FUSkJuUTlSZUZaSktiN3IweFZiSHFQVjNQWTRteXJ3NldJ?=
 =?utf-8?B?RzZHeDZOUUVtakpZZC9rZWRDVkNWYS9QZER0R1ZSblBTS3Bqc3pJSi83MDl0?=
 =?utf-8?B?M1pPU3NhTnNnVFIrbzQxSG1OZ25sZGVkMFJaVHM2S1R4UnVpUWlyVk1TV3Zn?=
 =?utf-8?B?QTdTeTBJcE4vTjFtVy9nTDg1N2xMSzRpdlVhNXlHTE5ZdjI5ZVBpWjBLTlBk?=
 =?utf-8?B?UXRVNmdyVXVsM3hQNFBuTHVuUGt2RzZya1FYbCtocmZaTVlRWENmRnlrVWRT?=
 =?utf-8?B?NzJ1NnhDdEFZSnU0S3NhZjhFUWNTeG9YQ1NURHo4NXVkWW5LSTZCbi9PMFFB?=
 =?utf-8?B?RFl3K01pVUlFamw4d2RMeDhRb1RVUUUwSE45SUlFZG5ZMzNTVFphRlppSGE0?=
 =?utf-8?B?ZXlyenJ4WmllbWZ4V0NhNElaTDNjSFFHNk9HcFFtMkVUZXl3azlQOUZDYjBG?=
 =?utf-8?B?MklNMEhkN2RFTEF1b3dzMU9WNjg0R1lpQUhDU0RjWXhmcERacThLS0dXTmNM?=
 =?utf-8?B?SUh4VzVLb2ZQTGR0Q2VRZDZCTC9sa0p2aU4yRDdYckNidG1WL0NaemllcFAr?=
 =?utf-8?B?RVdmeEEzMTRreno1Szc1ekhxY3ErZ1doczFJZnJ5UWVTSldFdWtwSWJFNHpM?=
 =?utf-8?B?MEpoak45TXBMRENXZ2x0MkdxOHFGMFRLWTlrQ01qU2l4Y2thWWQzWW5qeHdO?=
 =?utf-8?B?Z3FxMVRhdTVrT3JTMS9RNUFaTUlIelBrblp2K3RQUlU3d1NHdjVKQ2FTVys5?=
 =?utf-8?B?eWlPbjdhUFBQZjlLempRdEs5YXBIT1ZkWVZ4d3FxN0JQQ0RacVBya282dE0z?=
 =?utf-8?B?OTFoY2srNTVwUzBUYnhOK3RPU3hzeU42MVh6WFJiSGc0Y212V0ZFZmhqdHZa?=
 =?utf-8?Q?oV28=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 181de44b-1788-46c8-f2fc-08db972ca839
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB10348.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 09:57:06.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLy5YFgGjrNuXlyW7WSxjvZCPVkSnWyZAkb50zqwD7OKVQGWypf3HotpS/p/TX8H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6092
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2023 23.38, Andi Shyti wrote:
> Hi Anton,
>
> On Thu, Aug 03, 2023 at 01:26:42PM +0200, Anton Eliasson wrote:
>> At least freeze, restore and thaw need to be set in order for the driver
>> to support system hibernation. The existing suspend/resume functions can
>> be reused since those functions don't touch the device's power state or
>> wakeup capability. Use the helper macros SET_SYSTEM_SLEEP_PM_OPS and
>> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for symmetry with similar drivers.
> and why do we need hibernation in this device?
>
> Andi

Hi!

I wanted to test whether hibernation is possible on our SoC, even though 
it is not a common feature on embedded ARM systems. This is the only 
mainline driver that I found that needed modification, for my 
proof-of-concept anyway, and I couldn't see any harm in the change.


Anton Eliasson

