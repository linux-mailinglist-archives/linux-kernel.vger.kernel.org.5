Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D247DFD7B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjKCAJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKCAJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:09:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75511136;
        Thu,  2 Nov 2023 17:09:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc0d0a0355so12386895ad.3;
        Thu, 02 Nov 2023 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698970174; x=1699574974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxCT26H7bz0CIP8GeUtGqHHIYFxjBRrpCI1bXL610xk=;
        b=ahGeqqTj9Drcf77e0STZrtv9SqeOl+qibE/hDSHXGFIwoiL/5Zh1+DNlNzexznjJi8
         9m5rEk205MSqIdeo3vWUCrcfg0wQ6zwC+FK/p38ctz1HB5vYaTCG2mARZGoadYw1NfdK
         nSSBOxu2cUWLa2vswgRpWIhaWi8/thSWUzp8X3/MRevA/00jkbRiDdL0ZGIii4nxby42
         ye3zvaFi7ofJlcoacY9l/njjdrhPIVONMmaXw4O0wo7bk/L5CIbw0Cddu0QaIYHO+L+y
         TgVe8/qyRISN89xxXHxocvHNa5ktR5SF/LY8JS+JL5/jHBJID9MlckNlsH4LbFqvIaA0
         cm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698970174; x=1699574974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxCT26H7bz0CIP8GeUtGqHHIYFxjBRrpCI1bXL610xk=;
        b=ckpweDycBahGzrkZLaqeKI+9UfGsk3USMm76Af/9WDOZZIDs9fimSTLpgsFtuZD2oy
         KRGwu97BGsk4SFXiJp3dCKwvTsEm54/6IE+vQwsGY2WVd9Ymh3PWjvmbMKjMkf7+V/zA
         fVEkTP6VWy0s+rrd6viQ/6pCR9rFq0GvMFJ3uBXBxFEQdWwhDlWevpEIIsbPZc/ihQZ/
         z0peMZB9tvqJ7nDvsMFe6i8Y8Gd/Vc3KbULemrcWYuS+AsBQWy610xF1SV5mp4YDMFGF
         SxYiSoJmXpY1lxiy+yk7tbTpdyyRLOS5GAFFypztVMcYfarfnKxrkSnXr4S+o7kTk46r
         T0PA==
X-Gm-Message-State: AOJu0YxcNqMz5V2hoygKbEwuZK3KKp0q3IvTFrPEmGZAbeWjqfG176Bj
        V+qjSPqOwFvhWPJ3bW/HoCQ=
X-Google-Smtp-Source: AGHT+IEVSMjfhHf/0It1MrhMvFGlAEqsh1RRek7ufCor0pYrHAmtXfTfezIHc9vKA+EmQrQ8PQoNqQ==
X-Received: by 2002:a17:902:c94d:b0:1cc:4e78:d10f with SMTP id i13-20020a170902c94d00b001cc4e78d10fmr14469504pla.8.1698970173893;
        Thu, 02 Nov 2023 17:09:33 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001c0a414695bsm256560plf.43.2023.11.02.17.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 17:09:33 -0700 (PDT)
Message-ID: <272c0cfc-188a-41c7-9ba1-e1ba0f996298@gmail.com>
Date:   Fri, 3 Nov 2023 09:09:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: translations: add translations links when they
 exist
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     alexs@kernel.org, carlos.bilbao@amd.com, corbet@lwn.net,
        federico.vaga@vaga.pv.it, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, siyanteng@loongson.cn,
        src.res.211@gmail.com, Jani Nikula <jani.nikula@linux.intel.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20231028162931.261843-1-vegard.nossum@oracle.com>
 <0e003343-3c64-4fee-a56f-987a4ef6e336@gmail.com>
 <378b0571-a89b-43a2-8921-3f23afa0f254@oracle.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <378b0571-a89b-43a2-8921-3f23afa0f254@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/02 20:07, Vegard Nossum wrote:
> On 01/11/2023 15:56, Akira Yokosawa wrote:
>> It looks like this introduces hysteresis in successive runs of
>> "make htmldocs" and "make latexdocs".
>>
>> Steps to reproduce
>>
>> =C2=A0=C2=A0 1. Run "make cleandocs"
>>
>> =C2=A0=C2=A0 2. Run "make htmldocs"
>>
>> =C2=A0=C2=A0 3. Run "make latexdocs"
>>
>> This aborts with the message (under Sphinx 7.2.6):
>>
>> =C2=A0=C2=A0 Extension error (translations):
>> =C2=A0=C2=A0 Handler <function process_languages at 0x7f122f343420> fo=
r event 'doctree-resolved' threw an exception (exception: 'LaTeXBuilder' =
object has no attribute 'templates')
>> =C2=A0=C2=A0 make[2]: *** [Documentation/Makefile:128: latexdocs] Erro=
r 2
>> =C2=A0=C2=A0 make[1]: *** [/linux/Makefile:1695: latexdocs] Error 2
>> =C2=A0=C2=A0 make: *** [Makefile:234: __sub-make] Error 2
>> =C2=A0=C2=A0 Command exited with non-zero status 2
>>
>> If I run "make latexdocs" in step 2 and "make htmldocs" in step 3,
>> both runs complete successfully, but html pages don't have the
>> expected links to other translations.
>>
>> All I can do is to report the symptoms.
>> Vegard, can you look into them?
>=20
> Thanks for testing this out and reporting!
>=20
> I think we can fix this by moving the "is this html output?" check from=

> the TranslationsTransform into the 'doctree-resolved' handler (which, a=
s
> far as I can tell, runs after the doctree has been serialized to disk
> but before output is generated).
>=20
> I've attached an incremental patch, does that seem to work for you? I> =
test both (clean/html/latex + clean/latex/html) and it seemed to work her=
e.

Yes, it works here as well.

        Thanks, Akira

>=20
> I had a look at using a custom "visit" callback that would just render
> the HTML in place instead of manipulating the doctree, but it also
> doesn't feel right as then you need to specify callbacks for every
> output writer; there doesn't seem to be a way to ignore the node by
> default. Maybe I should ask on the Sphinx/docutils mailing lists what
> the "proper" way to do this would be.
>=20
> Thanks again!
>=20
>=20
> Vegard
