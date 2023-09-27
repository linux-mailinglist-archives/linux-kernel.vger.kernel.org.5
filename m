Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795E7AFB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjI0Gye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjI0Gyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:54:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E76DD;
        Tue, 26 Sep 2023 23:54:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32336a30d18so2690819f8f.2;
        Tue, 26 Sep 2023 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695797671; x=1696402471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DaZkwqJ0NHV5f8ZiALA0vRm4ZlZ22IDDgbWF0iyHHWI=;
        b=S2JEZ9iPbObq2OeJDLvLILCCcyNUhKnrwCX90HjPAOIYriyzalmOEOY9iyNZRqcGbY
         fMKwPxDqkdV2/0vsvbdzvjV9WRDpfSwyxulNWO0QV+I40OZPP2gkViI+tNAsDN4H+Gtx
         XWk9nEaI9ODrhRFDZjzLFX7uPDYVZKiBmd8WnPTUEtfwPpojUdytkZAnac42PqEoRpKr
         Mx+VYZbUeGFcWvBaYI2lW/zm/Jo/X9uuLkfDlCHjsSwdPiGPT+gUeYmxDEtpYFzZCE3d
         g7tmHekTH++szXdJM1BH6QtjW9+xvxuEV0DsyvgcZDLHEA8p/vc8oBMJAO04FLS63hAF
         7SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695797671; x=1696402471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaZkwqJ0NHV5f8ZiALA0vRm4ZlZ22IDDgbWF0iyHHWI=;
        b=htXVtfGL8o1xm8irK0iXZFSPcEpfhvrjjlJTWx6Ck4uhcrZPNiAyxo51owtRTHvuDk
         h3wO/nb6g/Zhzjjwi/lMwS7ak4DkZMQj6NdPj8VOd3sgc9POn3Zn0y4LNdPrHjw7w3+v
         LmzDplscSqGBFgG2kJiqXWcgOwhB+2qfjqzMlb8RRMSwnD2JPQE/bVKeix8k0J63YTcN
         Z+LaiEf4PcbhZJX+p9PRC73N4EZflAhmF59SjOKTHEiUZFaH7NtW96Ykd79LkIpyCi4s
         0n+ONEZ3FL19UVCok6+ZSZzzXkeUN5R7Dw7Vj2KrYj9mQrFdo5Ueb3hskl02v+g5X5cr
         C4bA==
X-Gm-Message-State: AOJu0Yzwdyfjld881s5wjSV2mtuHMTtAdjjOxOqYDKdanWVPrgBpYl46
        tfpB/g3BXzDlspp3Ye4hgIEmCBeTIJl4bGhZHRlKs7iaf2SzFg==
X-Google-Smtp-Source: AGHT+IG/aY6dk4QVZxCqAl3TV/et4sl3C4IHv8aEPNedVxEDjUwJn+/tnjC7Cf3SCvzyyVzDnU9B2KiXcRMz0NDDkGQ=
X-Received: by 2002:a5d:4811:0:b0:317:50b7:2ce3 with SMTP id
 l17-20020a5d4811000000b0031750b72ce3mr814195wrq.51.1695797670681; Tue, 26 Sep
 2023 23:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230926102914.6145-1-dg573847474@gmail.com> <CAMRc=Mf-tO5yaushz__Mq+em8o3Qp+QkG2Dc06JY9r-GoWPu=Q@mail.gmail.com>
In-Reply-To: <CAMRc=Mf-tO5yaushz__Mq+em8o3Qp+QkG2Dc06JY9r-GoWPu=Q@mail.gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 27 Sep 2023 14:54:19 +0800
Message-ID: <CAAo+4rX67i=P0yatabDqdhz8wS=rdpGVcwoRagbDLsvZa2JZrA@mail.gmail.com>
Subject: Re: [PATCH] gpio: timberdale: Fix potential deadlock on &tgpio->lock
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linus.walleij@linaro.org, andy@kernel.org, alex@shruggie.ro,
        aboutphysycs@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks much for the review!

Best,
Chengfeng
