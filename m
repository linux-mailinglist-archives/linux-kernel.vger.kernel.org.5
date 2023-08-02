Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32376CC35
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjHBMBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjHBMBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:01:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263D810C1;
        Wed,  2 Aug 2023 05:01:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 853545C0074;
        Wed,  2 Aug 2023 08:00:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 08:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1690977658; x=1691064058; bh=zVi/JMA+En+qL3o03VV3UqWYh
        0j95fdHyEoI1MTCf5w=; b=AivpHne/Xkk6rrPy3ffO1LHbaldmPUFJ2k0jhJlQK
        gCOI/52kxSG+njHESH6p8RWfv0gf95JdH19GO0YuDqzBV6p8gTrUIlvUYFlB1Dx2
        ehnqGb5TPOAjd8MGdggkvlWR6SxUmi79le/H951Nee14PPvgxRl3gD4g4pixEBOR
        9DWzR8oduZ+b2IPhdkzqwhvZKpaP7eiBiLz0NnBHXyrCTuFYjHdOk3c7yHFfz6Tq
        +5v4pKy+iaCu4BZ6XszHACJgHMhU74ne7QsZQsr8uTKrt9Ts2sFpwxgqtu/fFxy/
        1r2IzDLaixAZSIcNKHA4XfNROk7Pc9lnrWqIRA2QF+GAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690977658; x=1691064058; bh=zVi/JMA+En+qL3o03VV3UqWYh0j95fdHyEo
        I1MTCf5w=; b=Esw01sxqLELb0Fu/EdYdkRiRW9z07egIRvlhZADXWi4TRh4VLLv
        8VGsVTd/GYKGRuYNvsfXOtKhAteLatyktsz5QWHEiLkQ5MY5wl0ImMXTl9oJxiUE
        X+1RhkzQ+f3c9HuOMdPEKwepurDonW2t9TmrePdfRUg/oFg4Ns2wrBC0IUyAarjM
        bvQj5tMve/p7rReKO81S79Mc/8OxNUXwQpVlIcjXsqKX00utsb34W5x3A6GVxzmw
        JB/hu9PenIk5RSaYjx0R08mbz16usTN7dEVD88q3QHe0i+1ASUcSAFYBv2u//IDa
        WUeCKfJO0Q3l9ZkDBDPMzgOzV89R6rg9jMA==
X-ME-Sender: <xms:eUXKZBEslFTNgbn-eyrLE-MAaw-crjwnevtCoR55yT4aWHyF1M5hFw>
    <xme:eUXKZGUlUMgNrj1Pwl-WgdvhXZ748ex2rWr6kYKKeenuPhxnsiLWFmVNw75mspmO9
    56apUAmF07NxFU8rOE>
X-ME-Received: <xmr:eUXKZDICNVLT_bWknRyC7DQCuXvVvrzRIYYhXKWilkGjFi6ETDMJ0qduDOJSqTgJTR9G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeekgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepffhushht
    hicuofgrsggvuceoughushhthiesughushhthihmrggsvgdrtghomheqnecuggftrfgrth
    htvghrnhepheejfeetudelheduleeileekveegveevfeegfffgveeihfegleettdefffdt
    gfdvnecuffhomhgrihhnpehfvgguohhrrghprhhojhgvtghtrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepughushhthiesughushht
    hihmrggsvgdrtghomh
X-ME-Proxy: <xmx:eUXKZHFHhke0LUqC7Yek7J0XqngEKKu0ukxwc0ocg9GR2tEE8L29wg>
    <xmx:eUXKZHW1yy6RCLefW1qSUBAmnrSTHO41wEuJ7KbkKkLy7H6jmHQrYQ>
    <xmx:eUXKZCP9hTCBo6dS2HCj5gR2j8DiI0R4llM_KQqJH3p0PItOp_OgMA>
    <xmx:ekXKZDrb0D8y7bct7NLvqks29zK8LyGZ4FpjwfsnMznpbVBIKMh_kw>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Aug 2023 08:00:57 -0400 (EDT)
Message-ID: <43843fec-f30a-1edc-b428-1d38ddb1050f@dustymabe.com>
Date:   Wed, 2 Aug 2023 08:00:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: XFS metadata CRC errors on zram block device on ppc64le
 architecture
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, wq@lst.de
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, marmijo@redhat.com
References: <b2d40565-7868-ba15-4bb1-fca6f0df076b@dustymabe.com>
 <20230802094106.GA28187@lst.de>
 <3f36882c-b429-3ece-989b-a6899c001cbd@suse.de>
From:   Dusty Mabe <dusty@dustymabe.com>
In-Reply-To: <3f36882c-b429-3ece-989b-a6899c001cbd@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/23 07:03, Hannes Reinecke wrote:
> On 8/2/23 11:41, Christoph Hellwig wrote:
>> On Tue, Aug 01, 2023 at 11:31:37PM -0400, Dusty Mabe wrote:
>>> We ran a kernel bisect and narrowed it down to offending commit af8b04c6:
>>>
>>> ```
>>> [root@ibm-p8-kvm-03-guest-02 linux]# git bisect good
>>> af8b04c63708fa730c0257084fab91fb2a9cecc4 is the first bad commit
>>> commit af8b04c63708fa730c0257084fab91fb2a9cecc4
>>> Author: Christoph Hellwig <hch@lst.de>
>>> Date:   Tue Apr 11 19:14:46 2023 +0200
>>>
>>>      zram: simplify bvec iteration in __zram_make_request
>>>      
>>>      bio_for_each_segment synthetize bvecs that never cross page boundaries, so
>>>      don't duplicate that work in an inner loop.
>>
>>> Any ideas on how to fix the problem?
>>
>> So the interesting cases are:
>>
>>    - ppc64 usually uses 64k page sizes
>>    - ppc64 is somewhat cache incoherent (compared to say x86)
>>
>> Let me think of this a bit more.
> 
> Would need to be confirmed first that 64k pages really are in use
> (eg we compile ppc64le with 4k page sizes ...).
> Dusty?
> For which page size did you compile your kernel?


For Fedora the configuration is to enable 64k pages with CONFIG_PPC_64K_PAGES=y
https://src.fedoraproject.org/rpms/kernel/blob/064c1675a16b4d379b42ab6c3397632ca54ad897/f/kernel-ppc64le-fedora.config#_4791

I used the same configuration when running the git bisect.

Dusty
