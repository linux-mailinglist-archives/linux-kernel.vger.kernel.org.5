Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24FD7BFAAF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjJJMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjJJMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:03:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8DE10D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:03:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so9813642a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696939417; x=1697544217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX4yc2ifCmuKqzHMK3MHccD28II4Dp4X6ioalprFaxs=;
        b=P5Iiy9rIgxM97RNUnHMcq4ImDNVmKhD0re8PMyKXUGurBlTFCZTHrWdCTp8XImKjYJ
         l/luJtEbpgN+OeTd+OTmu/UPIZrwapBk02IQTGhA8qM4/+0mjdpq5FvPDM9JgNbJf6ru
         XTCmJUADGxAE7cIDh3fLuM+SQzuNuAiJWnvL0PkeJacyyPcTBSI7h8Z9HIcMSrDb5tQ4
         JP7J1ThlgVYO6UfeR5q8I4KZZa19T4kF4UxszG/kFhbY0cVn0OxvRsY/nlFFAa8hKf4F
         TDrztpl54FA/+VGhDBuMuQ+APAYc+GU/UBbvsMmPMk9VuvzHz2cCNtNVXhfTzSr8psIx
         CMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696939417; x=1697544217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX4yc2ifCmuKqzHMK3MHccD28II4Dp4X6ioalprFaxs=;
        b=SsTa3vYqne/c1XH1oN23wnXgEhRjnBELnXtI25j0Qit+tBBx7vUFU899ceY4J0Wj0C
         ABKOVdcXZRojufeSrnDz84BqbgL5nZ392nr1XHdamSuLIoNimHwrWltS1UfSL8FB6Uc1
         p5Nai2cYxZh50zsBMlm57EYpxqV1Wv3zJVPuOzaxKorAkA7WxzYemM/MNhj80pZM6e9F
         JMdEc55/pFXGG8CCW8CVZsCXl4CjrhzNb/dYU2n7+Jxw0PUMhS6MC4uufNiVwj5RHdPl
         DIRPECj2X7ogEBuTKmnxQvx8fTOKfqjmrE9w2GC2IsIfFtYdU2F9pLCbq19F1ikXZzzI
         h4NA==
X-Gm-Message-State: AOJu0YyY74U1k4y6uEe3e/zOlOvffadWQpt37tjB47z5rlYOMnoGUV+u
        rruc8VNpEXhJiIcsJ6719x03FSJilfiZuA8ZcusjZw==
X-Google-Smtp-Source: AGHT+IHI4KKF3FIJ0uJCbywmfLAUw9MWg96egfmrbGw29Bp2y3KgGmsoT1wnLQs1LvLRaZKLqck1rXvlL3d8wpTwgtI=
X-Received: by 2002:a17:906:2098:b0:9ae:6196:a412 with SMTP id
 24-20020a170906209800b009ae6196a412mr16962853ejq.69.1696939416836; Tue, 10
 Oct 2023 05:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231010101240.992984-1-max.kellermann@ionos.com> <2023101025-bungee-carve-2b4b@gregkh>
In-Reply-To: <2023101025-bungee-carve-2b4b@gregkh>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 10 Oct 2023 14:03:25 +0200
Message-ID: <CAKPOu+_x=C=1kpU_j0HoVn=o3PxRk=PH7a6YPeW8du_sQxJMYw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/process/coding-style.rst: space around const/volatile
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux@roeck-us.net, joe@perches.com,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 1:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> Don't encourage the use of volatile please

I don't mean to - but I figured IF "volatile" is used (for whatever
reason, whether correct or not), it should follow the same coding
style as "const".

Do you want me to remove mentions of "volatile" (leaving the coding
style unspecified), or do you want me to add some warning about using
volatile?
