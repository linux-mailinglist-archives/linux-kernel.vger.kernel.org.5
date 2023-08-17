Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136EE77FFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355370AbjHQVav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355363AbjHQVai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:30:38 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF976E55;
        Thu, 17 Aug 2023 14:30:37 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56c74961e0cso224383eaf.3;
        Thu, 17 Aug 2023 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692307837; x=1692912637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g53t29f35ZYHpkcprRfWSLQo9V1jtCGx0yCMyZlivcc=;
        b=TmNajexvH81PHgvxOAqieQl+IX3SQo2ZyfClzjiZ1GC7318XuHOQxRUtQx159zQluq
         7KILGoQC5+XLHRDEzBO84ZsQVD56J6TPOPjG57+YBeCS7TkmW1KwwTdALcnpBq/AP2Hs
         wlJq3jyjsTIee65y8HUQxyIdzlvoupMrRQUEVHwr5CbVnyghrAjtQUelxKErSL2YVrsF
         OOhe5mzBzFn7rEussbzflxNMQu2pzTZmSqxijeMH40XkHZuEPnghmpA+b5TwQuCBJ6aG
         A1k/eYFscmapPnxn0aFSVhnUJ86/8ytZlcoAMVLhqV0b49JCt7VFQdHyNOEtBnF8gqbN
         dMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692307837; x=1692912637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g53t29f35ZYHpkcprRfWSLQo9V1jtCGx0yCMyZlivcc=;
        b=gv26m4dLdD4/u7hB34P+LhJx/qL6usva3J7JLX9txI9Hxeua0klj0tSv+3DGF2luVJ
         i6NeXs/KAHAJv2MHL9s4ZbokR1oPbBX+uQLHKoFjcJhMF2f0IpOB0F3bdHd+0WQroNo2
         HD3eo9vnV0Nf/IBMHFCjIwCVA0/YitxQr1ANhxw1T4KKZ3kykTweEBvYvyrEaJ0HgH10
         PZ+0Mw7TDVgFQkR+OPc25szrvswYLVuHm/GMCX9e7tghpTtgCMCg06Q9nNCuNJolAGHr
         WEybPGBYPUK9THat1Jl86DTuTQPZ/XjMx/qvVyvrhbjITUysucoZGtS2s9UToNcIwpnr
         dlyg==
X-Gm-Message-State: AOJu0Yy7xY+RzvCYaA1PxsH2BJtTGO4Khrf8skMYGNdKJYdtPDL4WPO0
        blz8e7TBcXodse3kH3rg5a7lkeBATeId3my7TJY=
X-Google-Smtp-Source: AGHT+IGVTI2ysyH7jhpTeQk6oAZ5wghVFFFeH64e8c8mBkRYU869IhZ+gEB32vdu67fm9K4hsaAV5+2telvbDtKg10s=
X-Received: by 2002:a4a:919d:0:b0:56e:4ee2:9186 with SMTP id
 d29-20020a4a919d000000b0056e4ee29186mr1019213ooh.7.1692307837057; Thu, 17 Aug
 2023 14:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
 <20230817143352.132583-3-lucas.segarra.fernandez@intel.com> <574d3a14-6b6e-3ad2-2ce3-48c9d76e205c@kernel.org>
In-Reply-To: <574d3a14-6b6e-3ad2-2ce3-48c9d76e205c@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Aug 2023 00:30:00 +0300
Message-ID: <CAHp75VdZiLbE07h3Ei6OmTNFKJ69ksKMRk1EYOjSCxveR+JFCA@mail.gmail.com>
Subject: Re: [PATCH 2/4] linux/array_size.h: Add ARRAY_SIZE_OF_FIELD()
To:     Alejandro Colomar <alx@kernel.org>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        andriy.shevchenko@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:34=E2=80=AFPM Alejandro Colomar <alx@kernel.org>=
 wrote:
> On 2023-08-17 16:33, Lucas Segarra Fernandez wrote:

...

> Some comment about the name:
>
> ARRAY_SIZE() is rather ambiguous, as there's array_size()[1], which means=
 the
> number of bytes needed to represent the array.  I suggest a name based on
>
> -  _Lengthof()  It has been proposed to ISO C to get the number of elemen=
ts
>                 of an array:
>                 <https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2529.p=
df>.
>
> -  sizeof_field()  The kernel macro for the size of a struct member
>
> So, how about lengthof_field()?

TBH I do not understand the motivation of making this kind of
confusion and inconsistency. Are you suggesting renaming ARRAY_SIZE()
to begin with? If so, it's definitely out of the scope of this series.

--=20
With Best Regards,
Andy Shevchenko
