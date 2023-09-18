Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84DB7A3FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjIRD0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjIRD0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:26:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD210C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 20:26:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fc94307bfso1021348b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695007599; x=1695612399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VaQ8e1tcDCEt2B7UAQZ9FdVlA0XHxA3g4hSo8H0L68=;
        b=hiGaaq76ZVsCwdbfQbhN1IyYExQZchCK29kSrJgEvZx6WNUwsfMcTQUWpTY1od+S+v
         a5sZJtuPO/N7qojUe2ZkelVt/0H1ciAgNtv6d8+ZWFMj7AbPvTrsp57csWuYgJWWwWTA
         SKrCC9536aDemJ2XJ80yAuJZEsUHAcZ2L6a5jn9H1HAmBU10rovCfKHnN6dVuffb/R6I
         wSS+sQEvFkWY/iiY5yWXNHDMz0lwGMOOFWXKyg+eOHOmnZrTtXRLN38RRy28E9+xYKYM
         UnGoW0Z9zV1+mQwrHp/0Rk2N9KcVvknzA3CTKkMkXEUBz5H8SAIhMjE6gSLiKzGFsVrR
         e0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695007599; x=1695612399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VaQ8e1tcDCEt2B7UAQZ9FdVlA0XHxA3g4hSo8H0L68=;
        b=qlsS4pcc0Zu5XUnfRg6yBrQBolqd0IwoE0CMVWw26jIGC1ynRjs5wEjzPs+NZFmYWV
         aHCu7cT0+KYu2jGrUc7Vv9XedE0DFq//eRWq9Y2kAEv4A+sFzWLJS/TPMcNqZi7TcN6N
         DecN+6ebu8ja0S/HZshZMbpa+w1YX8PokVxi3q7AQ+qRfD024/eccPllAn8ef+HaJh9w
         YzzXsMnOnMuiB1oQUH8KDciI+ej9QQjubdQ3hH+lsvy8BcHS5A9YOkCtstix/pDBarmo
         tdGZnVn4npv3gTQ9vEQqIs1d/vxkwp8ZZeronIjHonEnzNUuLcoJj9Moth8lvc10VWgp
         PQ6Q==
X-Gm-Message-State: AOJu0YxsVtyAwrM1rh63k4JInZg6itIg0wgiyGxiVwQGr2/lTzdhWkyu
        HUZSR/SXrbeKxjTDW8lpPmUwRvla1L7MtZTRKSuVREqu
X-Google-Smtp-Source: AGHT+IFyK4NCT+TJ6VlKqffMam1F0Gs+1gXS7pHaEj1BGby9nBWhBT6mDO0k0lHDp9KYQG6Jnt2WmibMKRntKYgVkGk=
X-Received: by 2002:a05:6a20:3d0d:b0:13d:d5bd:758f with SMTP id
 y13-20020a056a203d0d00b0013dd5bd758fmr11098968pzi.6.1695007599258; Sun, 17
 Sep 2023 20:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230814015700.70156-1-nathan@nathanrossi.com>
In-Reply-To: <20230814015700.70156-1-nathan@nathanrossi.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Sep 2023 00:26:27 -0300
Message-ID: <CAOMZO5A=q8Kb1pmM0nALerka11F_U3024YrPbRSboX0ay_PyOw@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8m: Enable OCOTP clock for imx8mm before reading registers
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
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

Hi Nathan,

On Sun, Aug 13, 2023 at 10:57=E2=80=AFPM Nathan Rossi <nathan@nathanrossi.c=
om> wrote:
>
> From: Nathan Rossi <nathan.rossi@digi.com>
>
> Commit 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the
> register") added configuration to enable the OCOTP clock before
> attempting to read from the associated registers.
>
> This same kexec issue is present with the imx8m SoCs that use the
> imx8mm_soc_uid function (e.g. imx8mp). This requires the imx8mm_soc_uid
> function to configure the OCOTP clock before accessing the associated
> registers. This change implements the same clock enable functionality
> that is present in the imx8mq_soc_revision function for the
> imx8mm_soc_uid function.
>
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Should it also have a Fixes tag?
