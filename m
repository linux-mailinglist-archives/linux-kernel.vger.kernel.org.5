Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED577D2318
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 14:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjJVMbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 08:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJVMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 08:31:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A23E4;
        Sun, 22 Oct 2023 05:31:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c41e95efcbso339070866b.3;
        Sun, 22 Oct 2023 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697977869; x=1698582669; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XOMYBFKd8F3GC1twwAJy4M1O83pGevcctA9lZA8WXl4=;
        b=dEyUdMOrSdCe/Tbe9ylcBYa21fnFzFHF8iJJLolCZ4+ReYtnIGOEFHwVIvqprpwAak
         jBDicutooL9NDMgC+44lVdYvmBv0RPVvq0mVB/XNlMHymhVDN297ZBbvU0JUiYDZiHRc
         Xc2ILRR8FZQakLBH8KRx4ZGKDChvHFoflh6uERKa2fuYCAzYlN83RWbVEBBDuijrMrHC
         sN1T0taQQCTpXXLDiWFw3hXJRipYm/0PBNdnXzqUMIYqViuZUyeH3yncdXh06QKuEolb
         lJb6S0G3Sy1L6mFRr/0+9reGN+3+QLE5UugOxRH1NKqcl3Mo5GlRGlPNaMn5bqi0/J8p
         beGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697977869; x=1698582669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOMYBFKd8F3GC1twwAJy4M1O83pGevcctA9lZA8WXl4=;
        b=A/HRwhcej2b6cHwlgJFu+xvYTEy2TAOxc+W+ZNQ8wnlwXPdR0IzgLsvBFlixda9KPc
         3jg5SLansXwBzR/E4km1dbj2yudQ/jTJOkamP4TGJBIEZilJs8XvX5+cYWWJsnqKF8Bw
         WFJgb8Rrt7eqhc9rcaCaX5iCPeHPyOm/cxYAUDk/EakO6YRMbfnvIi27iyKI3Jfwiy4W
         xMGO8NDW63QzYPhq0hxZ2keLoIfkSvKlC3D1QWnJN/YnGfIJH6t6kgGwAhPzG40VGJRp
         qTengdgVb0eVc8nJrkuj2ERn9Fejbv3rHuWK0s6QXf1dMawGP9oOtwcsWmPJEoNXzHx1
         wK9w==
X-Gm-Message-State: AOJu0YyrIHL0usgY1WZgLpInnTUZUNU/kyUFhh4PtvWuBzLLaUCJjUcC
        qSmKYxI+Dtx2T80/2pMI+OQx9Qr8OoU+dw==
X-Google-Smtp-Source: AGHT+IGPYKycsiDu6PyO9oA5+5Eu8kUSYBi1Y2oUaTmSVDj8vv2eIL/iL2lmiOT+0JpFUMR+Wg/A0A==
X-Received: by 2002:a17:907:94c1:b0:9bf:4915:22c7 with SMTP id dn1-20020a17090794c100b009bf491522c7mr4983297ejc.55.1697977868530;
        Sun, 22 Oct 2023 05:31:08 -0700 (PDT)
Received: from [192.168.0.14] (ip-213-220-240-165.bb.vodafone.cz. [213.220.240.165])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906261900b0099293cdbc98sm5121720ejc.145.2023.10.22.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 05:31:07 -0700 (PDT)
Message-ID: <d85050999a2944a921a38352d1c371fdb3b8c29e.camel@gmail.com>
Subject: Re: Old WiFi modules -- for testing?
From:   Rostislav Lisovy <lisovy@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>
Date:   Sun, 22 Oct 2023 14:31:07 +0200
In-Reply-To: <ZTUIJHf1vdSxkXeX@debian.me>
References: <ca929e1d8197ace414a06b20151b84de3dd160f4.camel@gmail.com>
         <ZTUIJHf1vdSxkXeX@debian.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately I do not have any further info than what is on the
pictures.

Rostislav



On Sun, 2023-10-22 at 18:31 +0700, Bagas Sanjaya wrote:
> On Sun, Oct 22, 2023 at 12:16:04PM +0200, Rostislav Lisovy wrote:
> > Hi,
> > I am interested in donating the following WiFi modules to the
> > "Linux
> > wireless project". I guess they can be used for some automated
> > testing
> > or training or something like that?
> >=20
> > https://photos.app.goo.gl/sfootr3X8KVUBYf48
>=20
> From album link above, I can't tell exact models. Can you list ones?
>=20
