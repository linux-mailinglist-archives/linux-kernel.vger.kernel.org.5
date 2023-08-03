Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7376F4A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjHCVco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHCVcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:32:42 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F62D4C;
        Thu,  3 Aug 2023 14:32:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 890E332005CA;
        Thu,  3 Aug 2023 17:32:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 03 Aug 2023 17:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1691098357; x=1691184757; bh=eLWv24SU4JBoezYsr2cBSZuCW
        tzURtwoHCJ79k+/ThY=; b=EoAwEneRS1Q3qrgohOWIz3LCTx+pYd6hfkWB/X3/H
        UI4mNR0oHhGpKs+/oqeumswx7qvygco6TqruEbF7taSX30I6rxPToeiTfeMIIm6G
        YjJi0pFDvLx2tSZFLlIp02+5Bhl34MEYpZo6vyY0aR9fsGM9mxyQOKp1qvcklPXx
        Mz2oCZqW7U6nxZsun/6yUgSzd5dDSw+XDsVB4dsQMv/EiOyH1odzEC6aW7hgSRnx
        /jaWZlkwZ4sZzt0csYSLnxJqQt5IDBYyylSOtdmoxQ6SJMpsMoknheHlGqrcO2QU
        AbuwAYGbeBBn9Vw/JpLuiEVxwLSiyLjLQH43wbEAmuTIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691098357; x=1691184757; bh=eLWv24SU4JBoezYsr2cBSZuCWtzURtwoHCJ
        79k+/ThY=; b=aEIe+UJ4xDH3Qv3CHJNWzaM/Xvpr3yuAWucX6yi9DVCn0W3nEE0
        erpMIEmRmENsglMml6nBZf0HkMvNAlHtR3bR9eGV8T1+LzIvYJD1M2IuvqbTFOX1
        6+UQGt61JG9VXX2+zyU4/3Lq9Fb94js6vRCrqasDTa4rPxFc95q3gFSbL7d0ONe2
        1RjkIudibS4GO4le2k1BK4sJv/MRwNHMZ/9JrNoS1VmJatyaA4RrwOO1bvggv5c6
        v3SgqGaCUwbbBzHiR7oIXOBbhh+xfUpCmW4LMPiVKAvy5HpSYL8/H+IlUycJVCXM
        zDazKRAYKzsvx1MroKP6bPV1gjstVPL146A==
X-ME-Sender: <xms:9RzMZIf7Jbz5CLpXIZF9W-px4vZu0mpqhneeTpAQY_epZjH1LpB7zA>
    <xme:9RzMZKN-kXZZ5Mi_O_JY9f3kDB7NcA_ZIoXgoNBB2UAB9rJXAFEOVJO_81fJczO30
    6QhmObpvbL8CKsf_xA>
X-ME-Received: <xmr:9RzMZJi1XUNPzmdyvdmX7X71YghEK0e_cVm0J6rZkzhZwfH7ng6t_P_ounICbSrQkQ49>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedvgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffuhhs
    thihucforggsvgcuoeguuhhsthihseguuhhsthihmhgrsggvrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtueeltdfgfffftddttdduffekueegffehteevudduheduleegtedtffev
    hfduueenucffohhmrghinhepfhgvughorhgrphhrohhjvggtthdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguuhhsthihseguuhhs
    thihmhgrsggvrdgtohhm
X-ME-Proxy: <xmx:9RzMZN9NEF0b4kfvzL2vxJu1VxAcNxMKPS_zAUgQS_Vx5f-dQph5UQ>
    <xmx:9RzMZEtGv63Nq8YJgACCp-LFj86T8yeuRAzOm37Ro2VkBJUU1p-1Eg>
    <xmx:9RzMZEHsoitt8pGYHFBsTr0ZhLLeypqfF5v23598MzUmhj8GrFsAiw>
    <xmx:9RzMZCA0xVZAQ4E32lOUVL8f_O_AaudfV4yMy7Okuqjhu8lSGbMAwQ>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Aug 2023 17:32:36 -0400 (EDT)
Message-ID: <a0f05188-d142-82f2-74aa-6c9a6ae2bbc9@dustymabe.com>
Date:   Thu, 3 Aug 2023 17:32:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: XFS metadata CRC errors on zram block device on ppc64le
 architecture
Content-Language: en-US
From:   Dusty Mabe <dusty@dustymabe.com>
To:     Hannes Reinecke <hare@suse.de>, wq@lst.de
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, marmijo@redhat.com
References: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com>
 <20230802094106.GA28187@lst.de>
 <3f36882c-b429-3ece-989b-a6899c001cbd@suse.de>
 <43843fec-f30a-1edc-b428-1d38ddb1050f@dustymabe.com>
In-Reply-To: <43843fec-f30a-1edc-b428-1d38ddb1050f@dustymabe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 08:00, Dusty Mabe wrote:
> 
> 
> On 8/2/23 07:03, Hannes Reinecke wrote:
>> On 8/2/23 11:41, Christoph Hellwig wrote:
>>> On Tue, Aug 01, 2023 at 11:31:37PM -0400, Dusty Mabe wrote:
>>>> We ran a kernel bisect and narrowed it down to offending commit af8b04c6:
>>>>
>>>> ```
>>>> [root@ibm-p8-kvm-03-guest-02 linux]# git bisect good
>>>> af8b04c63708fa730c0257084fab91fb2a9cecc4 is the first bad commit
>>>> commit af8b04c63708fa730c0257084fab91fb2a9cecc4
>>>> Author: Christoph Hellwig <hch@lst.de>
>>>> Date:   Tue Apr 11 19:14:46 2023 +0200
>>>>
>>>>      zram: simplify bvec iteration in __zram_make_request
>>>>      
>>>>      bio_for_each_segment synthetize bvecs that never cross page boundaries, so
>>>>      don't duplicate that work in an inner loop.
>>>
>>>> Any ideas on how to fix the problem?
>>>
>>> So the interesting cases are:
>>>
>>>    - ppc64 usually uses 64k page sizes
>>>    - ppc64 is somewhat cache incoherent (compared to say x86)
>>>
>>> Let me think of this a bit more.
>>
>> Would need to be confirmed first that 64k pages really are in use
>> (eg we compile ppc64le with 4k page sizes ...).
>> Dusty?
>> For which page size did you compile your kernel?
> 
> 
> For Fedora the configuration is to enable 64k pages with CONFIG_PPC_64K_PAGES=y
> https://src.fedoraproject.org/rpms/kernel/blob/064c1675a16b4d379b42ab6c3397632ca54ad897/f/kernel-ppc64le-fedora.config#_4791
> 
> I used the same configuration when running the git bisect.

Naive question from my side: would this be a candidate for reverting while we investigate the root cause?

Dusty


