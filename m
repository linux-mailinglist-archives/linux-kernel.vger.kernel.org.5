Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40FB78B425
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjH1POX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjH1PON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:14:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2CC11B;
        Mon, 28 Aug 2023 08:14:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 860961F383;
        Mon, 28 Aug 2023 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693235646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7/Km/jKsLvw/NKxCW99seF9lWJLgqSMYTjISiIIMKY=;
        b=juD3P3pg0IENzHff2mRHsgSANByBQnrGln5C3hvcCzhoqJYhonY1TUGpJLhJZGgf0MvXcP
        +PtjfZah9cWEzPiDO9+Gvo9S+TGt9hH960NL/IiEVuDEDqEVWDLncPTnHthr0sf4alrAhT
        fb9+7E0p4jOMihGKndQ3IVBUdJb8VL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693235646;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a7/Km/jKsLvw/NKxCW99seF9lWJLgqSMYTjISiIIMKY=;
        b=dvUTP6SlcF9q6wm+rNzL0rLC/Km4gFRV9ib+4Lm87cMoll/Oolti2EbwuhB3xhWG+WRWFB
        7gf3JDwBCteRWTDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3502913A11;
        Mon, 28 Aug 2023 15:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y/UUDL657GTYdgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 28 Aug 2023 15:14:06 +0000
Message-ID: <9aec0740-2482-d3ad-caf2-5e6278a050b3@suse.cz>
Date:   Mon, 28 Aug 2023 17:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, workflows@vger.kernel.org,
        tools@linux.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <87jztf37ny.fsf@intel.com>
 <20230828133554.GA818859@hu-bjorande-lv.qualcomm.com>
 <CAMuHMdU+3oj+-3=f5WFVTRsKQjqCpU8SnVqKSZGk8XRxhsDcVQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAMuHMdU+3oj+-3=f5WFVTRsKQjqCpU8SnVqKSZGk8XRxhsDcVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 15:48, Geert Uytterhoeven wrote:
> Hi Bjorn,
> 
> On Mon, Aug 28, 2023 at 3:37 PM Bjorn Andersson
> <quic_bjorande@quicinc.com> wrote:
>> On Mon, Aug 28, 2023 at 11:14:41AM +0300, Jani Nikula wrote:
>> > On Sat, 26 Aug 2023, Guru Das Srinagesh <quic_gurus@quicinc.com> wrote:
>> > > This script runs get_maintainer.py on a given patch file (or multiple
>> > > patch files) and adds its output to the patch file in place with the
>> > > appropriate email headers "To: " or "Cc: " as the case may be. These new
>> > > headers are added after the "From: " line in the patch.
>> >
>> > FWIW, I personally prefer tooling to operate on git branches and commits
>> > than patches. For me, the patches are just an intermediate step in
>> > getting the commits from my git branch to the mailing list. That's not
>> > where I add the Cc's, but rather in the commits in my local branch,
>> > where they're preserved. YMMV.
>> >
>>
>> May I ask how you add/carry the recipients in a commit?
> 
> I guess below a "---" line in the commit description?

Does that do anything special in commit log? I'd expect (and I do it that
way) it's rather just adding a

Cc: Name <email>

in the tag area where s-o-b, reviewed-by etc are added.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 

