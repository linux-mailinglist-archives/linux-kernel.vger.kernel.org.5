Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E2675B7D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGTTVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGTTVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:21:46 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09594171D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:21:45 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7878e573827so52999139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689880904; x=1690485704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FZ6SubRIeZ4k0ML1ha4iOHMnlI2c5uKQpXEuDc5R/0=;
        b=A6SkHKCBcEZmDKQnyiNHkX1gL/BwiwSpSj3GTHbNNeZcqEc8ndS1Q3v7BSE8XPV10i
         ZmtBYGPk/drb+NB9U66L1zbgHWNPPaTQPQgZ26Ep/cBYAixKQckkP3zA9cL7u9zSIn7V
         IJibuObOY34z01S0N3p/Z2xVvv43KhdhVzXl/C5aGmJvxvwnEUB3S5ehIhoxsSkC+k8K
         lhuZnWGHavjNrxUJ3dCaobjEG3tAsnGOCTDd5coUVzoTCnYuLe3XYAD36e0CMCpoW6o6
         VOWUOQMBZubjrZmesYyeOPDI1gUDuKopru18nKMK09Tltcszudq8Hti49Bjjh0IcnCbB
         FJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880904; x=1690485704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FZ6SubRIeZ4k0ML1ha4iOHMnlI2c5uKQpXEuDc5R/0=;
        b=b0BcIpaGfT9snjrMw7Mn47ZHgDm/8sFVOBCe21+FBZZ4aobcukevvr7AbJR8MW7xVP
         M52rPi4u/kM4Lty7PTKCMJXe/Aa1cuf6pcSWuOpSaoj2SUCoNmX0DQz4A0DteV4ed7Jx
         OREkqTrodDwXT5uS2U9GnYYfqOwi3N8eZ2l/bFZEjkVbn67lVXMoqDZ5vfChxOck+PEC
         d5p2apb+6gCeFSTwh/bO80IG6C07pnb7qTk9ZEAUbfy7024+OGcm52+LhoahqMYCyjtI
         t1GfEjiPVNXH0XWHfUsExn/37dPAP8AR+9VCifNWe3WKvuJ4X9PIEv9hkSXWjpwe1595
         kWaQ==
X-Gm-Message-State: ABy/qLavlZh+wSIFyhpPPPwuKpLAFvK5RNrD0EAmv76YlH9j7jhxkxwK
        2vVRSZdxcdEGSAZZud295vIdIRofCYFHAUwZDls7pY+v5CXg2Qlj
X-Google-Smtp-Source: APBJJlGxEtg0om++OPbPp6XITjhWUGx5iJ2sJL4w7NeCt+/U0OI2O5WFKshSFtO9z9SGejOHXLmG0i0Shy9Ny97+9S0=
X-Received: by 2002:a05:6e02:12c7:b0:348:7d73:20a8 with SMTP id
 i7-20020a056e0212c700b003487d7320a8mr11306545ilm.1.1689880904399; Thu, 20 Jul
 2023 12:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <202307120814.vWPY6URk-lkp@intel.com>
In-Reply-To: <202307120814.vWPY6URk-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Jul 2023 21:21:33 +0200
Message-ID: <CACRpkdbYPAiOa4QU+PUxVjcOtkBT2O7fogh51VvSEbFPutH7ng@mail.gmail.com>
Subject: Re: drivers/pinctrl/qcom/pinctrl-ipq5018.c:244:27: warning: unused
 variable '_groups'
To:     kernel test robot <lkp@intel.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srirachan, Bjorn,

is this warning valid or something I should ignore?

Yours,
Linus Walleij

On Wed, Jul 12, 2023 at 2:32=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Sricharan,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
> commit: 725d1c8916583f9c09e5f05e5a55dd47fdca61c1 pinctrl: qcom: Add IPQ50=
18 pinctrl driver
> date:   5 weeks ago
> config: arm64-randconfig-r015-20230712 (https://download.01.org/0day-ci/a=
rchive/20230712/202307120814.vWPY6URk-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git =
ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce: (https://download.01.org/0day-ci/archive/20230712/202307120814=
.vWPY6URk-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307120814.vWPY6URk-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/pinctrl/qcom/pinctrl-ipq5018.c:244:27: warning: unused variabl=
e '_groups' [-Wunused-const-variable]
>    static const char * const _groups[] =3D {
>                              ^
>    1 warning generated.
>
>
> vim +/_groups +244 drivers/pinctrl/qcom/pinctrl-ipq5018.c
>
>    243
>  > 244  static const char * const _groups[] =3D {
>    245          "gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gp=
io6", "gpio7",
>    246          "gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13",=
 "gpio14",
>    247          "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20=
", "gpio21",
>    248          "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27=
", "gpio28",
>    249          "gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34=
", "gpio35",
>    250          "gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41=
", "gpio42",
>    251          "gpio43", "gpio44", "gpio45", "gpio46",
>    252  };
>    253
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
