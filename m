Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3C7D8596
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjJZPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjJZPIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:08:01 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C310F7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:07:54 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57e40f0189aso565377eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698332873; x=1698937673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VVZOgV4TaU7C0kwXpqOjxAK7iXfSpgYkTcenW5IXZCQ=;
        b=Ystq3Hh5JeLfSjjbRpDvjFVwwC/prIdM2A0lA0q4ziu7Q9VFgSYprW0WvxXBKTpsJj
         yOK0fsiLOeHwes+HCGiPXcCxg9KaAdXnR0QfUyZJLdTZ5hxUHvVrgF5oNIbvkY9B9fWZ
         qm7KyfySEmkfTg4HixGPIVVHNHwX2RXdDF53jyahz8/y7wn+9Y8MWxsiIPn3ySB1jYgz
         yjI+4UZLOSz7BZbtf7Au3acPQgI39M/7quwjhrfVooErOSGeQinUK1E/as+YhcktCOMU
         Um1DijYOgbh/lT3J21lD7eZXQDWo+EfPU42g+sCEiBqbmoYioNGT10I4olzJZW2p3Ilp
         JeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698332873; x=1698937673;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VVZOgV4TaU7C0kwXpqOjxAK7iXfSpgYkTcenW5IXZCQ=;
        b=iK8hmjdrorHx+QY9fZTN6dEB8xSF/ps6atJ7QVApxSrZgLW4AwJWb+WISlBq+Y5IRr
         1w0e45H+YAaHN2ROT6JJphECdrVKpcL+ee9H4mR5v4eWxV4J6cm7r4t5gX8EdB8t0q+o
         tAYOnmqjhR8EPQh7DvVGOxR0OVRdMi/+le9EPMjNCjp3d5jT17tXQuFd+Qd2SoMqrauI
         AInYl8XLFEM1IDOZGVy1Nlg4WdT+G+yUtSzJYdIM8fR3Ut25NBii0HAusoB7iVEKIA1v
         0IwitGibZDDbygihy5HT6PeHmmCOAR0ilE9TjSV887zHiZv06+pdO63T35IKxJabKnnQ
         jrYQ==
X-Gm-Message-State: AOJu0YxGENmtKBXzOXxFoM8RXvgg2APaYq5rS9zfvnrN80eMCO6TqLmy
        YKd2fAuxOhodiY9iwasZIbaGryQIJ0dBuQixEKw=
X-Google-Smtp-Source: AGHT+IHLUFJBwxSSzLEhcDelbU5shJZAeiSRkaxAOjkWV6IZG8ga8EyA3fKdt8864gXDPzN4c7ZVovuKUSAhi22VkH8=
X-Received: by 2002:a4a:d032:0:b0:57b:7e41:9f11 with SMTP id
 w18-20020a4ad032000000b0057b7e419f11mr18552571oor.2.1698332873236; Thu, 26
 Oct 2023 08:07:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6fcb:0:b0:4f0:1250:dd51 with HTTP; Thu, 26 Oct 2023
 08:07:52 -0700 (PDT)
In-Reply-To: <b0654dab-eb43-444e-a820-db169812e1ba@efficios.com>
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
 <20231026121621.358388-1-singhabhinav9051571833@gmail.com>
 <20231026091222-mutt-send-email-mst@kernel.org> <CAGudoHFXH_FDgKRaJvVgQ3W8wD2TC=8yhiNm1NECApnQ-CNAZQ@mail.gmail.com>
 <b0654dab-eb43-444e-a820-db169812e1ba@efficios.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 26 Oct 2023 17:07:52 +0200
Message-ID: <CAGudoHEfjSAim6Hh-qYPY+qi8nbLx7J3YdpGgFwSvD7xbeYR3w@mail.gmail.com>
Subject: Re: [PATCH v2] Fixing directly deferencing a __rcu pointer warning
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Abhinav Singh <singhabhinav9051571833@gmail.com>,
        akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, npiggin@gmail.com,
        shakeelb@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> Drive-by comment: perhaps use rcu_dereference_protected() ?
>

Definitely.

But as I mentioned even after applying the patch there are uses which
should have been reported (and consequently sorted out). If one is to
bother with any of this at least the entire file should be covered.

-- 
Mateusz Guzik <mjguzik gmail.com>
