Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC1771272
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHEVrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjHEVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:47:12 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905901BCA;
        Sat,  5 Aug 2023 14:47:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 40C3B5C005C;
        Sat,  5 Aug 2023 17:47:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 05 Aug 2023 17:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1691272028; x=1691358428; bh=PDZaMOIU4UarYbs6ckRvGTabK
        al4sIaEiC324VR5DDQ=; b=Crr8G8ou9IOsrquDkzJgJjxC4v9hdtkyHX0m6QXX3
        XjfggUJFzOqBY7mJAbL9XfM4jPftOKLdgdc5fjn+PNus4dWfBOu55T/35xXyGl0A
        A8TvbW0oSfyaY9OL+cvCENBFwfdc/8ZKNRNbsgy8KaYVXUeoNteKHZoS25K62Sbi
        KEUQAkNPv6CsvvzCGmY8DJXuHVuh2+8TjLX+P0MWf3mFREfdvDpm0wSbzZfwGLCF
        HLmIMqzrqAgTGaqRATot8sd/An+8OluHf3+/50YxWKILx815kEZgNi3CmOFsWeeg
        85BuIsr2LL+GcmcEMu+7I3DbvlK5YUNUvX0MKapTU7uQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691272028; x=1691358428; bh=PDZaMOIU4UarYbs6ckRvGTabKal4sIaEiC3
        24VR5DDQ=; b=xZBsAFcWvRVAlrWM7IkitFjChkIiEdItEmMKO9HPKCJJuzwL7X1
        hSk4ZxPj1GcjHeZZd4Rlq/ck7x5lB/iYkOmaQBz85bfAB9diplLjEpWkxTEanmWM
        FkLwGY3o3ezmjKmqIRXxvyPfvOh7A3inxbx8RYmzina0F4HnJQOsTDgvLrXV6hxb
        P02sVJ0edeW14yZoI7e8ZuEQD4iLe6ct/4l2842WLpCb+fgoCnpSKLJrLLUa9RNS
        3ZI9Srf+D24meFlt5isRw63XfbffcQl24onUBNq5Pocke4s3uM+fvVwUWhFfkG8B
        71Pjmj2vRLOamQ5aGpfy5kcIpKiswm1f9Xw==
X-ME-Sender: <xms:W8POZE3X2nzRIHJGDcvUfgxzSdyVoOd6L1fT9ExOIfg5kel0_0t02g>
    <xme:W8POZPH1jk-giyhf_0G3cZ1HMtlDMqQrvwqqn8k4zV3oraTLzoomYuMB-A_43G1ge
    QbpSwj1dT9zCtp7lik>
X-ME-Received: <xmr:W8POZM6VYQBwkfesfIHSNm-RzQmbPpte0n-tNeFHecKy-EdbB0nPCIArdWbetHDBXnV6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeejgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepffhushht
    hicuofgrsggvuceoughushhthiesughushhthihmrggsvgdrtghomheqnecuggftrfgrth
    htvghrnhepieffffeugfdthffgkeeftdektdetfefgveeuleeufeeugedvheetueelgfeu
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepug
    hushhthiesughushhthihmrggsvgdrtghomh
X-ME-Proxy: <xmx:W8POZN1I79i2wcucKA4KYHEoknJw6ZqaMSzn3EbjLk5UQas6twdNkg>
    <xmx:W8POZHFYWGcvhxFlrOlbaNE3cg1sWBMpGI1gnrDw-tZmqQmL9MURfg>
    <xmx:W8POZG_KJWeqcTGYNvzZCV61nzxQO4Iwo6xm90qr9YKDZwpqxKPJ5w>
    <xmx:XMPOZPBuTd2upMA1TgvwdcBvFRHG096ch8b90zTdVwjuYPWe2CJFng>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Aug 2023 17:47:07 -0400 (EDT)
Message-ID: <a10b62b0-2b17-581b-db7d-d346f9578ff8@dustymabe.com>
Date:   Sat, 5 Aug 2023 17:47:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] zram: take device and not only bvec offset into account
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     minchan@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230805055537.147835-1-hch@lst.de>
 <20230805074645.GA907732@google.com> <20230805081306.GA29615@lst.de>
From:   Dusty Mabe <dusty@dustymabe.com>
In-Reply-To: <20230805081306.GA29615@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/23 04:13, Christoph Hellwig wrote:
> On Sat, Aug 05, 2023 at 04:46:45PM +0900, Sergey Senozhatsky wrote:
>>> Fixes: af8b04c63708 ("zram: simplify bvec iteration in __zram_make_request")
>>> Reported-by: Dusty Mabe <dusty@dustymabe.com>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Btw, are there any interesting test suites you want me to run on
> a > 4K page size system now that I do have this setup available?

The patch is passing tests for me. I ran the Fedora CoreOS root reprovision tests
(which are the tests that caught this bug to begin with) and the trivial reproducer:

```
#!/bin/bash
set -eux -o pipefail
modprobe zram num_devices=0
read dev < /sys/class/zram-control/hot_add
echo 10G > /sys/block/zram"${dev}"/disksize
mkfs.xfs /dev/zram"${dev}"
mkdir -p /tmp/foo
mount -t xfs /dev/zram"${dev}" /tmp/foo
```

Dusty
