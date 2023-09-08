Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CAD799253
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbjIHWeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbjIHWeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:34:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60801FE8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 15:34:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-502934c88b7so3828561e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1694212443; x=1694817243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PO154UcSZcrz3tXTl/MZKegJHXMqR7fPgmRCTaap+vo=;
        b=hQUG2ykfCRv+FVpMJqD0CNZOLuR5Sl974BmGwAf4GTpzvjh2VTKNN+4VMaI2Mwsa5+
         o+4K4M7I6X8EDUfzhHCbglDvcBZLHairUmuRSS03PfocVpv0cEOTEthTAD9ttD6b2lyC
         E+JXMWADYYuaOYzCPXdDSaI8zuiIKsqaSMeOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694212443; x=1694817243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PO154UcSZcrz3tXTl/MZKegJHXMqR7fPgmRCTaap+vo=;
        b=wbxpbXseetPtCvylhcj/frSNFcz1lMYCHfhXSUxuHNVU2wdk6bkcINUXIXHij1nQu2
         ofa0H7Dpja9afRNdAhRsvRgeTgDzQ4sHVKmv95p0ybe92fthxMei0qA59U0i+PA52aIF
         4NAFrwcOwr0WsSjjY7XDPYc6t1IG/vEV/QqlNiZ1tjzlotTDtIWelyVHCWDRy5aU7Jli
         9STNQYcLmxnNbB4TCn+4TZ1Qv83W659+FRrDsot3txP0FF4g5+03AsciE8BgPvc/hA+z
         7KS7e6xKk60xfPx5JeyUYnMTOSnawHlApchxi37hi2VTtO8cFnrbU+Hfy7w+/B0qmWVo
         xNHg==
X-Gm-Message-State: AOJu0Yzvg3Of9HeFCXUcZ6yTGLSrioOD9mpbxYNv3p5H8ADUjAjXW2us
        8Gu04ae7CHQoeF8oNXcU6Jg7AGjR6ttYH+vwFZ9BAQ==
X-Google-Smtp-Source: AGHT+IFQldZaiCcSl33XjQQDgr9ZwW9JI85Cmxu/aFpL2zRncKqSpDAFtR7Y6BY0a7xpE0ZcuoeQWA==
X-Received: by 2002:a05:6512:ace:b0:501:c406:c296 with SMTP id n14-20020a0565120ace00b00501c406c296mr3069265lfu.31.1694212442735;
        Fri, 08 Sep 2023 15:34:02 -0700 (PDT)
Received: from [192.168.1.128] (77.33.185.10.dhcp.fibianet.dk. [77.33.185.10])
        by smtp.gmail.com with ESMTPSA id mb18-20020a170906eb1200b00997cce73cc7sm1574991ejb.29.2023.09.08.15.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 15:34:02 -0700 (PDT)
Message-ID: <170e3110-e4c6-8060-3238-d2296b4f0d88@rasmusvillemoes.dk>
Date:   Sat, 9 Sep 2023 00:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] scripts/setlocalversion: also consider annotated tags
 of the form vx.y.z-${file_localversion}
Content-Language: en-US, da
To:     Sean Christopherson <seanjc@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
References: <20230804120536.2339722-1-linux@rasmusvillemoes.dk>
 <ZPtlxmdIJXOe0sEy@google.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZPtlxmdIJXOe0sEy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 20.19, Sean Christopherson wrote:
> On Fri, Aug 04, 2023, Rasmus Villemoes wrote:
>> Commit 6ab7e1f95e96 ("setlocalversion: use only the correct release
>> tag for git-describe") was absolutely correct to limit which annotated
>> tags would be used to compute the -01234-gabcdef suffix. Otherwise, if
>> some random annotated tag exists closer to HEAD than the vX.Y.Z one,
>> the commit count would be too low.
>>
>> However, since the version string always includes the
>> ${file_localversion} part, now the problem is that the count can be
>> too high. For example, building an 6.4.6-rt8 kernel with a few patches
>> on top, I currently get
>>
>> $ make -s kernelrelease
>> 6.4.6-rt8-00128-gd78b7f406397
>>
>> But those 128 commits include the 100 commits that are in
>> v6.4.6..v6.4.6-rt8, so this is somewhat misleading.
>>
>> Amend the logic so that, in addition to the linux-next consideration,
>> the script also looks for a tag corresponding to the 6.4.6-rt8 part of
>> what will become the `uname -r` string. With this patch (so 29 patches
>> on top of v6.4.6-rt8), one instead gets
>>
>> $ make -s kernelrelease
>> 6.4.6-rt8-00029-gd533209291a2
>>
>> While there, note that the line
>>
>>   git describe --exact-match --match=$tag $tag 2>/dev/null
>>
>> obviously asks if $tag is an annotated tag, but it does not actually
>> tell if the commit pointed to has any relation to HEAD. So remove both
>> uses of --exact-match, and instead just ask if the description
>> generated is identical to the tag we provided. Since we then already
>> have the result of
>>
>>   git describe --match=$tag
>>
>> we also end up reducing the number of times we invoke "git describe".
> 
> Dropping "--exact-match" is resulting in unnacceptable latencies for me.  I don't
> understand what this is trying to do well enough to make a suggestion, but something
> has to change.

Hm, that's quite unexpected. I mean, before that commit, I think that
setlocalversion, especially when run on some dev branch, would _also_
end up doing at least one 'git describe --match=v6.5'. <goes digging>

Ah, so I assume that in your case you always end up in the

                # If only the short version is requested, don't bother
                # running further git commands
                if $short; then
                        echo "+"
                        return
                fi

case, i.e. you do not have CONFIG_LOCALVERSION_AUTO=y. Can you confirm that?

> E.g. on my build box, a single `git describe --match=v6.5` takes ~8.5 seconds,

That's a long time indeed. I don't really know why it can take that long.

> whereas a complete from-scratch kernel build takes <30 seconds, and an incremental
> build takes <2 seconds.  When build testing to-be-applied changes, I compile each
> commit ~15 times (different x86 configs plus one for each other KVM architecture),
> which makes the ~8.5 second delay beyond painful.

Sorry about that. I agree something needs to be done, but the commit
above fixed a real problem with -rt kernels, and the refactoring just
made it much easier to follow the logic IMO - and, for the
CONFIG_LOCALVERSION_AUTO=y case, did reduce the number of times git
describe gets invoked.

Until I have a bit more time to think, could you try setting the env var
LOCALVERSION when building - it can be set to anything, including empty.
Then if I'm reading the script right, the scm_version() function won't
be called at all.

Rasmus

