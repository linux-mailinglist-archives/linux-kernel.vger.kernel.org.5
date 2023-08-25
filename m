Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0AD78821E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbjHYIei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbjHYIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:34:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EB919AC;
        Fri, 25 Aug 2023 01:34:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a4bcf8a97so546858b3a.1;
        Fri, 25 Aug 2023 01:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692952459; x=1693557259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgzx8F63rBkw8Acwc9kphpz+DGZxrgaRRBPshml8yTg=;
        b=ieSSJr0YvynmqFt60dA0myx0kj/odAJccDa2J8M+ix1CgG6IdjCUQg20+yRT8To5tg
         wosiFi/b/0lZmytgeOkUuzorWqxW973Mlhr+5vAT/ioRH4wTqESGd/S2O+LKwleKHkWz
         vIsvRCHk6MhdDabYdiK2bLfIangpg/CW82zKkNA6cqPB3VRto1YLnM1PZ9Bd+LzqFnjQ
         fSeEki7zPDNZhp8SEYpx+XIfU5QJZKtDJx2g14r9riGGrs1gE0efc2V+JTeDUSsWVDRn
         3A5SdwKA9dkcFGBVF6FkUS8fY0rfey4tymIdGcNcw5qWhw8+rX7xJysZaZv39NHBbrPD
         802Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692952459; x=1693557259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jgzx8F63rBkw8Acwc9kphpz+DGZxrgaRRBPshml8yTg=;
        b=a3S4W5r0np+STlM/DCpiZEITwwMXd/ZkddK6MauEf+EFT8I9lNNBa3P8AxiorGNrC0
         uUlOcS57oJo4IMZ1UH1OBYQnYnbDgL7kYbjAQbEOcuuqB47ABJIXxZdd45uUMx1F6WxC
         hEcI3C4m43/Rmy+Nq+1f+HHG8gW4Xs5Z3Q8DBm4uaINeh78GNL8wkNk9yLmZVHh8nNh1
         h7Z+PHn76fGu0SjYuGvKpIGaMBH2/8UFqfS4WzsCmW9IhOY2EU6dg0TnMioNgqxuTg1P
         KFoib6hzZbzTa2wIIWI6whAMXTcFuX52MmfVLr6Ee5QEjI6jkPUjP+hE7rI24UlsT/0/
         zMNg==
X-Gm-Message-State: AOJu0Yw3R4m2XiofXX16u+OBR/RgMUo0PcWxbfHq3RuNrtLQg/wfKqb9
        hoBU8/OvnDAcVOiyLgn+LGehO0wxrWMlFD6qDD3Qr/ih
X-Google-Smtp-Source: AGHT+IGL5czZRDEgJVI+NbUpVz6KWCPLF+mPtS8hx3jiiW6slIrXgTe6zfz2x/eEAeRw8Y33oQaT/did5z6vyACPVBg=
X-Received: by 2002:a17:90a:3fc6:b0:269:13f0:4b9a with SMTP id
 u6-20020a17090a3fc600b0026913f04b9amr14447281pjm.7.1692952459024; Fri, 25 Aug
 2023 01:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOiHx==NiPG2GdZNrJn5hPEdi70Spe9Kc9CHO5NjnATAjCgUsg@mail.gmail.com>
 <20230814093621.289754-1-artem.chernyshev@red-soft.ru>
In-Reply-To: <20230814093621.289754-1-artem.chernyshev@red-soft.ru>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Fri, 25 Aug 2023 10:34:07 +0200
Message-ID: <CAOiHx=nU7POAE8SFD833inLm59CMiNmQpE28XWLjVcHS5a5zHA@mail.gmail.com>
Subject: Re: [PATCH v2] brcm80211: brcmsmac: phy: Remove unreachable code
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Aug 2023 at 11:36, Artem Chernyshev
<artem.chernyshev@red-soft.ru> wrote:
>
> wlc_phy_txpwr_srom_read_nphy() in wlc_phy_attach_nphy() can not
> return false, so it's impossible to get true value in this
> if-statement. Also change those functions return types to void
> since no one using it.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>

Since Broadcom seems to be on vacation or so, have a

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

to have at least some feedback.

Regards,
Jonas
