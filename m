Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB6A7C030A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbjJJRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjJJRyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:54:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F7399
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:54:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40651a726acso55203335e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexity-net.20230601.gappssmtp.com; s=20230601; t=1696960440; x=1697565240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU4LX7gzUrwftw4dBN6chmZzToLhmhcRecLCdbJFz8c=;
        b=KRWHxRAKsJ9gWOPJbcKjIwSu+8yArSECmU+SeVl/idY58tTkDDNnyL2baW2ooxrTIz
         j+hxu9hv4TpM22GgeoPxeaEaQIpzFsNmrUXrudO1gClcWOsPMEoJHk/CIovNsUdzzg93
         emN5h8yWqE3DUVznC13sJUgT6P9Vm4D1erl1SrvX5yvY2e93POGy1tNhmsdziXlCspnm
         uJbX5EZa3HU7/YGHtpIz5p2faEu+PEvKXKQ9jygsiwtYb5Y+ByAOWDMsSrs9E9mQgbE9
         e6BS264Md7o0b5vkFE3Lpt6w97klYUdhVh2UUHQ60CTjGn1BUFRn3ApwWpuASbd2DkW2
         qR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696960440; x=1697565240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU4LX7gzUrwftw4dBN6chmZzToLhmhcRecLCdbJFz8c=;
        b=MtHSfj3UEunB6YOCseOhvCGNvkdW64tI5K/Kz2kz/pkhyqLcpf1fK0ljsGsxLvvhJ6
         Q+lPn/pNIROSys2/Xpb6VV7K8aJZFjragGRZn6dHTQJGUjMLkk7EMgHtCHMEA83QUMq8
         0T6IpCTOCxIdi9373ELLJEXAWr5muoYKwRMEoLH0FvTm84mR99B6n5+xLWoltIcL7ZAm
         6iDIUKzIBPBwHNFXk5UrGg9p/snNUqWYVUUvAMsZD5V8mqNve9SbECSiFKTW5AUYQgk0
         cHGM2jmRYt8mfzs6cgWwhSi+5b9rI3vZLEEUj9AeQYOjm3CONm2MQLNjrgNu/Ly7c8SD
         pCuQ==
X-Gm-Message-State: AOJu0Yxv7HADMu/q0aTiYidmaWCdR8ufuUuZ7CjDhzR51+Bwo4BBip2p
        To8bSo+MLEtAITT4obr+shk8oU6oSOAdnRaLTshS+Q==
X-Google-Smtp-Source: AGHT+IHO1eFWk0KYIDBG6wm+v4RZPBvfKTS0MdKA4W6ZNtmZcMnyjrycrl0Rub26vR/CfwzWwVmTJBUtnfGQaBjR65Q=
X-Received: by 2002:a05:6000:613:b0:329:6d66:85c0 with SMTP id
 bn19-20020a056000061300b003296d6685c0mr13277018wrb.43.1696960440347; Tue, 10
 Oct 2023 10:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <m334yivh1f.fsf@t19.piap.pl> <CACRpkdZ+7YFYNPXuiFU=JRZYOia5V+145dpRrLN+LTuHE5RuUA@mail.gmail.com>
In-Reply-To: <CACRpkdZ+7YFYNPXuiFU=JRZYOia5V+145dpRrLN+LTuHE5RuUA@mail.gmail.com>
From:   Deepak Saxena <dsaxena@plexity.net>
Date:   Tue, 10 Oct 2023 10:53:48 -0700
Message-ID: <CAC4N5EPWQw9dCEeOLgS_rfn-hc+dbNoOXqTvCc7sue5rRVOsCQ@mail.gmail.com>
Subject: Re: [RFC] IXP4XX MAINTAINERS entries
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Deepak Saxena <dsaxena@plexity.net>


On Tue, Oct 10, 2023 at 7:02=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Tue, Oct 10, 2023 at 1:44=E2=80=AFPM Krzysztof Ha=C5=82asa <khalasa@pi=
ap.pl> wrote:
>
> > Are you OK with the following?
>
> I'm sad about you stepping down, IXP4xx has a mean time before failure
> of 60 years and we've only done 20 years yet! ;)
>
> > If so, perhaps you can pick it up?
> > Or state your Ack, or something :-)
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I sent a pull request for IXP4xx today already, so just send
> this to soc@kernel.org for direct application.
>
> Yours,
> Linus Walleij
