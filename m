Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4651781BBB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjHTAau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjHTAaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465504C1CB;
        Sat, 19 Aug 2023 16:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1BAC60DCA;
        Sat, 19 Aug 2023 23:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F76EC433C8;
        Sat, 19 Aug 2023 23:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692486271;
        bh=+j9WRqednGH1+NxFhVTgnVGn/8Qvkzl/efsDkEK8uhM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HO4PfW0Vmh2ehaeIt++wBNm79ATKd11hq0U5+B92cMoT0BOBJwmRzCK/BxSCcHvi5
         CC6Ti8JOyjOx4hdHkMq1AcyrjnkKmLLWs0LkOgrWYuRFynrTqoPe73eVLPTarYzKaJ
         XF6cD0Hl+395lViiWPxkvk2mqav6W2V9mkJPoKd/j1PLX5puLu5mQZKLVhgZtyeKXi
         k5/PpZJn8kZb+QTLeWm3CDsZujElEKEOz/6gYmjppYRGKY0XQ5to2ochUpNCZpiqs6
         2KehJ9QZzz5+N6No8so/oKVYySVa3goKhpXcG72PLtmrRR16oAShvhdc3vS8ftLNeu
         mZsaSqlY2tGXw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56c711a889dso1413272eaf.0;
        Sat, 19 Aug 2023 16:04:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YwZw/nfjuSX7/3yW08PYfSa/BteDT1V/VNAKBGnUeurrStdiFBk
        U3I9hJR4xVfpEAGxRBvA7FxtSFhc/A+PvgGPnc4=
X-Google-Smtp-Source: AGHT+IGyF9vfyHiext9WLpiou5vaMm6T5IbSdf7XdCrPvrTrtIwD+GibBH5g6g7fKzc0ObxkJ0SuXemN3HeHkHD2wuM=
X-Received: by 2002:aca:2216:0:b0:3a7:83f6:9d19 with SMTP id
 b22-20020aca2216000000b003a783f69d19mr3868919oic.51.1692486270519; Sat, 19
 Aug 2023 16:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230721171857.3612639-1-masahiroy@kernel.org> <707999896.6490583.1692479291135.JavaMail.zimbra@nod.at>
In-Reply-To: <707999896.6490583.1692479291135.JavaMail.zimbra@nod.at>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Aug 2023 08:03:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATX4uekv=W9Rsvwxc-3fuNJvUZsAO49qV_TCzsWZu76XA@mail.gmail.com>
Message-ID: <CAK7LNATX4uekv=W9Rsvwxc-3fuNJvUZsAO49qV_TCzsWZu76XA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] UML: hard-code the result of 'uname -s'
To:     Richard Weinberger <richard@nod.at>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, bp <bp@alien8.de>,
        dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>,
        mingo <mingo@redhat.com>, tglx <tglx@linutronix.de>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 6:15=E2=80=AFAM Richard Weinberger <richard@nod.at>=
 wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "masahiroy" <masahiroy@kernel.org>
> > We rely on 'uname -s' returning 'Linux' because there are os-Linux/
> > directories, but no other os-*/.
> >
> > Supporting a non-Linux host is unlikely to happen.
> >
> > Let's hard-code 'Linux'.
>
> While I agree that a non-Linux version is unlikely I'd like to
> know why we can't keep the uname -s check?
> I guess to avoid unnecessary command execution?



Just because 'uname -s' is meaningless.

Just build 'Linux' ones irrespective of the host platform.
If it works, it works.
If not, it does not work.




--=20
Best Regards
Masahiro Yamada
