Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C4076B5E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjHANbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjHANbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:31:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D4C19A4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:31:02 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-407db3e9669so257511cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690896661; x=1691501461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsO+Zl7CUnASQXP0pNGTsohTGDW6byIjsx/QqCHb86M=;
        b=5gjWQUE+sGzZJUk8GTBNFCY2Ukgx6UJk/M8SSHTXcRt2509TjEJ/WjPI5RKsHCVNAW
         2LTuYOywqRolGqGCuu54wlTDlrslWqzjzb7KGVcAKKZ7ywpgaaZTliSPzNSsTHl+ats7
         RJnG6m7Z+lnsV6GjWrrXLjbtjvzFZxLTDU81zurkRAvr8eH6/dIYOQgJKkgpnSy/dOtR
         5+OHad0k3vx830SWafnBRC7ggC0olu4NBZnUn9VnLw+HCOQ2+x81tIvz8Srgba/ZFmfY
         TB0kPhcvZd3hhF5KxmSe+4EmBftUaFowGjRHIx0D58zrLg/zIpoS6Fl0h2oGe0ZGSeaQ
         bZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690896661; x=1691501461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsO+Zl7CUnASQXP0pNGTsohTGDW6byIjsx/QqCHb86M=;
        b=Q5vfoDYg4vprYSlLjpXG3vbCg2vS2YA189VcbUGfx0P5CjVTGyPW8GTBCako4x7OBU
         ejgXi4LVO6WG50+wX7VyNxl78kxelFCjCt2i1ERWbNz9kFOz4kwFamyxsC1jUDfV1bcn
         wbaq5nEgMcke3ZVLFAlvL9LwqEqhtlCbEi9GyIHRciIxOkx3Tpzo22OXKeS1UwQAlVJX
         MX+Cjn2AevW4wh8fcp2SmbJ8HveYzMo8AMrR7eY6PqRS8NYmEAgdcOCB+AOZp0CJoSFJ
         7q6vXD42dHe8SlGxfsuAf8inuU5tzp06JSRK3FBBPdlrFJzYLLb/iJp9EPWcpDTeW53B
         XDTg==
X-Gm-Message-State: ABy/qLZd15cY2MYG0ah+EC18V8yTWAUASPN25X8aHQd+txErRlu7whOR
        atXELVXCFrtQ284MFoXXuPk+63F/7dgHuGbeydI82A0X6ZcZevlf3/Q=
X-Google-Smtp-Source: APBJJlEqdUmI77KcWGZOQ5yXmFTXtucrwvbdJ6vPrG+TQqRszduBf4M+gW3Q8Pzz3v+94F5oF0OgckOE+YZTgaO5ZTE=
X-Received: by 2002:ac8:7e8e:0:b0:403:b1e5:bcae with SMTP id
 w14-20020ac87e8e000000b00403b1e5bcaemr812745qtj.10.1690896661367; Tue, 01 Aug
 2023 06:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230731230736.109216-1-trdgn@amazon.com> <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
 <CANn89iLghUDUSbNv-QOgyJ4dv5DhXGL60caeuVMnHW4HZQVJmg@mail.gmail.com> <64c905205b2f4_1b41af2947@willemb.c.googlers.com.notmuch>
In-Reply-To: <64c905205b2f4_1b41af2947@willemb.c.googlers.com.notmuch>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 1 Aug 2023 15:30:50 +0200
Message-ID: <CANn89i+-CQy3T-uLebzszGBv7m_CQ4DVeC2OORYn-6GpKgPZQA@mail.gmail.com>
Subject: Re: [PATCH v2] tun: avoid high-order page allocation for packet header
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Tahsin Erdogan <trdgn@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 3:14=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
>> This exactly same allocation logic also exists in packet_alloc_skb and
> tap_alloc_skb. If changing one of them, perhaps should address convert
> all at the same time, to keep behavior consistent.

Sure, I can take care of them as well.
