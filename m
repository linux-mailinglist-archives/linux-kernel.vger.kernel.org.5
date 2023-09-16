Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721227A2BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbjIPA2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbjIPA2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:28:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6841193
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:27:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8066136a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694824056; x=1695428856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E8Y6H+CGjrqtUwepfVg3ZapOU4tcqDJDh2TjsLFPfcI=;
        b=TcQG2Kb/Ip8PZWX2Cc3dnN58Lcb4fXG4xyYDtQTu/rKnLSdEkxpVSyDC/bSmfyG4iB
         ByiFLo9h+G356gxS9zNIYHVdUfDVD3r1NbBN918JCGUk/xkk4Nf0LzCw5g0+PMkU3TvU
         NVOh5inKCcyUTVoqS7mOSOg/iy2LR2HjB52xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824056; x=1695428856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8Y6H+CGjrqtUwepfVg3ZapOU4tcqDJDh2TjsLFPfcI=;
        b=GNy48otxLHIcbcyJL34lNxj/R/3zqCQyLMW4DXSn3qreQwlQB+VDn3DB9bzqMtFc9l
         n2SNU339BY1pXE6a76072plL1/NMmVc3C4AeSEZdVvQYc8YZnO9TOkSMbfqlx4nhZ3Pf
         b42pKW4lB9uoZRvk/b0x5vL9g9LUkmiWRPYRN9E5HPrSa9IU7LRjKdSDAIV4263vcYpr
         IJuroh9ZYxaVwQ6vl4PoA1sPRLVnqGXeNPS/T7iAx7tCuWKDpPsNCfOJMlVlG4eZ/A20
         QoRiFj/dWQtDRSwm+ipjZloeJyA4eFnNruE+ReX/lrzPwZj/isnL/furmpmYhRtZMxfp
         zeGQ==
X-Gm-Message-State: AOJu0Yyqo1PLBGRyMMtG7Hxt0t2r/qrGJTk/Ko4QLTuFCto404jkWRZd
        ng4z8jewcCro/GpikZqxokOGLdU7t8+k2PGrKUskpci/
X-Google-Smtp-Source: AGHT+IGtFLlbLhpf3YYb7yR9dj7qe2vIbvDLPd+ZCuCrEnvFEcoHc6eGgTdloIiRXfHaOCdoBp0sog==
X-Received: by 2002:a05:6402:34f:b0:530:5149:b725 with SMTP id r15-20020a056402034f00b005305149b725mr5000746edw.4.1694824055828;
        Fri, 15 Sep 2023 17:27:35 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id bm10-20020a0564020b0a00b005236410a16bsm2864994edb.35.2023.09.15.17.27.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:27:35 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso820452866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:27:35 -0700 (PDT)
X-Received: by 2002:a17:907:80a:b0:9a9:405b:26d1 with SMTP id
 wv10-20020a170907080a00b009a9405b26d1mr8271589ejb.5.1694824054952; Fri, 15
 Sep 2023 17:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-9-willy@infradead.org>
In-Reply-To: <20230915183707.2707298-9-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:27:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
Message-ID: <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,MIME_HEADER_CTYPE_ONLY,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> +       "1:     ldl_l %0,%4\n"
> +       "       xor %0,%3,%0\n"
> +       "       xor %0,%3,%2\n"
> +       "       stl_c %0,%1\n"

What an odd thing to do.

Why don't you just save the old value? That double xor looks all kinds
of strange, and is a data dependency for no good reason that I can
see.

Why isn't this "ldl_l + mov %0,%2 + xor + stl_c" instead?

Not that I think alpha matters, but since I was looking through the
series, this just made me go "Whaa?"

                Linus
