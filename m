Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB8F7682CD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 02:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjG3A1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 20:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3A1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 20:27:39 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4BE1708;
        Sat, 29 Jul 2023 17:27:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2A8B932005B5;
        Sat, 29 Jul 2023 20:27:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 29 Jul 2023 20:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690676854; x=1690763254; bh=5oVpB8cg24iMSoIqJPBrzh1VmgfW5bnbCkN
        cqJv/vSY=; b=NnbNweek63dx+oTkE0HkrT2cbIXFOBsFi1ljUwofsDoEoSBlgSl
        CTzCfaadIgqqaugqTvzKiqmY2itx2uY9Kgcrqa/eQEowNZebTGthd6uA2BShrEto
        gxLxJJJi6uLnrPfuxtqiiJq5n9htCzwNH7GHz9YSV4LetlCiroE3TYLPZERAlxiW
        gHzJIQWDfpVjRljBwINppGyOZG5QuVrMK48lFoKG3i7YCSg2VxoGixmJeXievni6
        m4d4PzWFVQezyB8ne01Up1E9y1yQjLwPDgJWPvjggXZgFiNF6v/NSZYhsTVUJW8v
        HWEvHnNvRiNzxQEgmKPeWud/1HRSyzIN9Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690676854; x=1690763254; bh=5oVpB8cg24iMSoIqJPBrzh1VmgfW5bnbCkN
        cqJv/vSY=; b=x5h9cydy/S0jYnVAfqDGbjqw6OL/FitloQa9bP5TsbcXzmhF+My
        T0UmtyrI8l3hV657cwcmuwUcxP9hhYok6TprtPc7G/AxK2rIySycfACGeEFeBFl8
        Kjc8D9ABYKLD4McgClcoNsO4GzqlQooHxfYMNNzps4sCR6T88htEoYWBz0BO2qNi
        Bdjj6Z6ttg9p+diLgjmkQ7956Ldfd4Q9Zs0BzVRnyX1wjz6Mpqso/pPJ7ZQzsf1T
        EeV2OibXxLE6qNmCklV/4ewmKP4j38eOSPWxNDqm4STtKLaTsYQnzWKaS0A9ke29
        umG+PwlAZkquaPWi0YPa6qTBREo7rhVDbIw==
X-ME-Sender: <xms:dq7FZLZ-5OI54pKHfjEaI2RguRjDFcCMk4jtLmQB8T1V_QRdnEiDYA>
    <xme:dq7FZKaT39BdCLE_CUK1-tuNcIeqZyqLTZOdjU7NxkyczI-_QVypPgtvkqgefXU0S
    7qbFHPAv4Kw>
X-ME-Received: <xmr:dq7FZN9ZQdYlw5cOKie_VqSYAb7NeLUqt3qpBGryRvxI4cpJWHFAtodfJ8I_eMmgERVEzYI61fdrkdQmf8Rn5bbejT690aMBAi1vGlhqvZMZCGBaskw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:dq7FZBoKCXFOCK1QrHM6hnS9Y2bIMruNH5vK0tSsJxj16bZnhDnYug>
    <xmx:dq7FZGptKFgyS-YsyLkT9alBIFeHAoNTu_noMkGCowufprz6nEyZPw>
    <xmx:dq7FZHRuIibnjzqQf9_B2lNjxm-DFVVLs8SgDOGizsBSVa3E8MU02g>
    <xmx:dq7FZLB-ieafJmrnZCXjbRBZ3l3_Ps60ynjikPNgalStGxIaOIwemw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jul 2023 20:27:32 -0400 (EDT)
Message-ID: <2afc8cac-5749-f7f5-1278-2e1252924ba4@themaw.net>
Date:   Sun, 30 Jul 2023 08:27:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arch/*/configs/*defconfig: Replace AUTOFS4_FS by
 AUTOFS_FS
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Joachim <svenjoac@gmx.de>
Cc:     autofs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727200041.21404-1-svenjoac@gmx.de>
 <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/7/23 05:07, Linus Torvalds wrote:
> On Thu, 27 Jul 2023 at 13:01, Sven Joachim <svenjoac@gmx.de> wrote:
>> Commit a2225d931f75 ("autofs: remove left-over autofs4 stubs")
>> promised the removal of the fs/autofs/Kconfig fragment for AUTOFS4_FS
>> within a couple of releases, but five years later this still has not
>> happened yet, and AUTOFS4_FS is still enabled in 63 defconfigs.
> Ok, I ran the script, and also decided that we might as well remove
> the AUTOFS4 legacy naming stub entry by now.
>
> It has been five years, and people will have either picked up the new
> name with 'make oldconfig', or they just don't use 'make oldconfig' at
> all.

Agreed, thanks Linus.


Ian

