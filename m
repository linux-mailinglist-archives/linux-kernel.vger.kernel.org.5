Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D03777A0D2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjHLPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHLPcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:32:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BA7E54
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:32:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-997c4107d62so387748666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691854375; x=1692459175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JwnWLFinw653oNORKs4oXtvLbt2zukEGt8KGvHgfiqE=;
        b=GxrL/xwGoGAAZgQOKN5/zptPrlOzgbYeNVlWnVR+/Edj1v0XD9U15hIFQb28kLr+yB
         fqXgGeLP2IA5NmIxIY3nXFJLe5sw7AZYPLjQ8cYX5owk8MOIhDT/cP5leHKH4ZRRyVhA
         GNZPwYOCFklYE5b0uPNwzi2u3P0mYi3un5qWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691854375; x=1692459175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwnWLFinw653oNORKs4oXtvLbt2zukEGt8KGvHgfiqE=;
        b=esYJ0Vy21vOybX1JMZF/HCGpkpDM3jYk8lemOlBn+CeL3yN7o6PF6KuoG16eNiAYGA
         6eEUeVO8Wnrur0Wd/COsyi68p6pVkIbSsWX9e/IYoaSruNCZEO7PaHzRibvet44rJykd
         Xss3Gr8Zt+YaLB/fVzbdmTHXW1FFAesMYT3VOz+2ksy73ZLX58Pb+SrYfTjDlh/WfwhU
         Q18il1VUruIeF5SamQoMZpC0PnC83crvQduB+TxcC4Yre3l/a6dksW2ApBRR1tiQqsxq
         4CQ5FiWZ4C439m79NYxVGY1jcOjZQatIaWFYT9oiTaCniqBQ21FRuJ05iHbOWptUtlcH
         YJQg==
X-Gm-Message-State: AOJu0Yx05P35jDToHHb8iMX/ZmJ1Czu+meGGEC9iCkal/61VobStgQKc
        6bdhndtAPXeQ0hai7S/UDt85jJaTFx6mT4gmRWEHDbh3
X-Google-Smtp-Source: AGHT+IHS5Hla7oCCYmWiOxUfs3EhdM5ZjfzqehIZocMfSwOWU+aZldnN1DyjBKohG7bYxYVdlpFVfQ==
X-Received: by 2002:a17:906:5307:b0:98f:c9b:24ed with SMTP id h7-20020a170906530700b0098f0c9b24edmr4240175ejo.67.1691854375123;
        Sat, 12 Aug 2023 08:32:55 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090640d200b00993a9a951fasm3621422ejk.11.2023.08.12.08.32.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 08:32:54 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-52327d63d7cso3802042a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:32:54 -0700 (PDT)
X-Received: by 2002:a50:ed06:0:b0:523:10fa:e132 with SMTP id
 j6-20020a50ed06000000b0052310fae132mr4112327eds.23.1691854373968; Sat, 12 Aug
 2023 08:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <4987ff9fa2467bc036759afac47b95c77a415963.camel@HansenPartnership.com>
In-Reply-To: <4987ff9fa2467bc036759afac47b95c77a415963.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Aug 2023 08:32:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whk-PxHDjEe_kNN-ZANc032cnYTd9unO8OBQqUq6C6fqw@mail.gmail.com>
Message-ID: <CAHk-=whk-PxHDjEe_kNN-ZANc032cnYTd9unO8OBQqUq6C6fqw@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 6.5-rc5
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 23:45, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> The short changelog is:

Hmm. Neither the shortlog nor the diffstat matches what I get, and you
also have a non-standard truncated pull-request format that doesn't
even show the expected top commit etc, so I think I'll just unpull and
wait for you to actually verify what you sent me and make a new pull
request that matches what the git contents are..

              Linus
