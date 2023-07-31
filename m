Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C36376A060
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjGaS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGaS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:27:09 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E510CE;
        Mon, 31 Jul 2023 11:27:07 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-403b3213d8aso29227601cf.0;
        Mon, 31 Jul 2023 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690828027; x=1691432827;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlds1JSHqdvGEcoD53cMNrPoiV5pobOGiP/ZwpDCtn0=;
        b=P1aF1FixjZ4baIYKYQcJMUVQaSeaTglgrEdiuYk5riBlYLQpN+E+EYDI+6kbnReSwW
         rzac9hbGX0DzvG8WeU3ewBjK3U6HX10Ih8FMGBve2TOiVsY8YuqzDXHUBxkpNiHo4HwG
         bDvPKUO3p+BreKfyAg1KDl8W8wiKZ/79POOAAywzP+HLlmTiiB0x/Hm7Aooac3U+qBzk
         KzAQd/2WYcm8j8V425Hepnc60xRDcXrPBB82JlKj7ybFl78LrajuCbuBdd5g5AvMmGJm
         0WyUmekI1W7w3+i0ZgQjZblbhGeNeQWrBlnLWte33GTcyQ4BaVeAFPTKNIGXTFrVUJGZ
         q3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690828027; x=1691432827;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dlds1JSHqdvGEcoD53cMNrPoiV5pobOGiP/ZwpDCtn0=;
        b=Bi4duX0Wn1M3cPpqAu65AXw34AOUv+hyuJvNnAJWpJt0zf53GB9K1wjrDTtnjP5PIJ
         uJVlaGng3FaKUEP53MEuW/KgXsUW6PfgAAZDH4C7UWJLO07VqjehoJi4Jlh7G/VSpG0M
         pgS4nNCTI8NxhHME5kAO1n0AriZVmtGnbtrjAyoGGtYzZaGTcJmJxgZsH4rBNmoFyhuD
         3opP1MuanXsfNvNTuVsKMTxrsMUP3rgaKo7sRF1nbM2RCgpxpeQjPQuVmrnk7yEa+Sc0
         mWGQHOi1E/VsUERKeZSr7DuN87OzdmpCnKwZ3rgnEC85raVF6qMJGxnFOB9iFIFhL4WJ
         GXQw==
X-Gm-Message-State: ABy/qLZ3HpmkkVlm3IWHtsuycUwCwBygs+tOEzN6ohHHoboBJLErYpos
        8A1+YOahz8VhCSaPO9hviKA=
X-Google-Smtp-Source: APBJJlHExGsd6nGILbuTvECZzdZBY3jFS8hu+E6pTEriShJKCMmQSHY57RF73HuiIyswSqG7MoBXlg==
X-Received: by 2002:ac8:7e94:0:b0:3ff:2923:48a with SMTP id w20-20020ac87e94000000b003ff2923048amr15303100qtj.3.1690828026873;
        Mon, 31 Jul 2023 11:27:06 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id l6-20020ac84586000000b00400aa8592d1sm1916807qtn.36.2023.07.31.11.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 11:27:06 -0700 (PDT)
Date:   Mon, 31 Jul 2023 14:27:06 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <64c7fcfa3d428_17de01294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230731145713.178509-1-gustavold@gmail.com>
References: <20230731145713.178509-1-gustavold@gmail.com>
Subject: RE: [PATCH] net: ipmr: Call ipmr_ioctl() directly from
 ipmr_sk_ioctl()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo Luiz Duarte wrote:
> Call ipmr_ioctl()/ip6mr_ioctl() directly from ipmr_sk_ioctl()/ip6mr_sk_ioctl()
> and avoid sk_prot->ioctl function pointer indirection.
> 
> Also, delete the sock_ioctl_inout() helper as it is no longer needed.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> ---
>  include/linux/mroute6.h | 33 ++++++++++++++++++++++++++-------
>  include/net/sock.h      |  2 --
>  net/core/sock.c         | 20 --------------------
>  net/ipv4/ipmr.c         | 33 ++++++++++++++++++++++++++-------
>  4 files changed, 52 insertions(+), 36 deletions(-)

The helper function does save some LoC, it seems.

My comment came during review of the series. Now that that is in,
fine to leave as is, imho.
