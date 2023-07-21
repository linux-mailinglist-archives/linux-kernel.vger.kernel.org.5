Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53575C41A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjGUKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjGUKL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:11:26 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E52D7B;
        Fri, 21 Jul 2023 03:11:25 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-799fa82fb44so22333241.0;
        Fri, 21 Jul 2023 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934284; x=1690539084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQyjXThTHSvlntttE4dIaIKlxVs+RlQSyZMyghuQbM4=;
        b=ZlccAMBF1FMQtiVaxezdKr+2BEwWj99W8XlToz7phlexCFOa2NMaS9EgpfJsZ4j612
         QxbjpkjH+FNYI/TamKjSTgzt5kpxrxeuFgY8xtMw8wUdznBqVgMW7CcqMV8uG9R+ClLm
         apN/CUosMPLFCzewQrg//M9GRg4sIcD2NcOIdJ5mnJGcKxP8ob4FWBcjUa87rf7zzNQM
         /sRY5jOBTCUhvAviTFmpHPt1j7lzWnU7qXu7qu6+DWfmtkiEcHiC1NF9MNFSJ0UGg0Vw
         GIBteD/cg5acLJ9wNZSaqX+QgQqqvC75Fil7IGwsqTpPn38v8lmEn6kVxfsURXNRPY0+
         lPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934284; x=1690539084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQyjXThTHSvlntttE4dIaIKlxVs+RlQSyZMyghuQbM4=;
        b=UcecYfHRWOWHSS5ITM+v6kU31JgHtOAgd6NQ3z7JbYMv7yi2uJURnRvY7tnaMG6aXx
         rtWrRFL3gsBwL7PW/E8+dqqgyN0goxLVonGUgdiOYWIqwbHpVtihoQEfgchRqPkK/JT4
         tPp/oPeMGiniixQcPjjjRO/PDxg7OJRvuUpesXAtOhq8xZ26TMpOB1W92neBeoiIvV83
         OpMNshLCCcKZZSYngeecw0GQDQBFpBywPZgkvOgSymgDLv2Sc5HDbiy+6QDxnrPlUd3A
         xQT7u9VntlkdFt07AZA9o9EDmz35Laap/oENNe0a6zSOL6lZRJhK9msdU4938JDodfpr
         XP3g==
X-Gm-Message-State: ABy/qLZIy65wIFzMYfn3H4qKfG8YcACvG05wR/Gt/KF1aoqAa+5VM58L
        edRNjKLr9ECHuhHOY6RmbF8deCZgrazs0+5BmzQ=
X-Google-Smtp-Source: APBJJlHSqiF5w6gsYBakpaJ0MPcmOYyfVrOVtKx7I3QoIdON5OlC6t9EWkV59fJv4nAwMslw12bgGoidvD5QgOA4jDw=
X-Received: by 2002:a05:6102:364a:b0:446:ff4f:bfff with SMTP id
 s10-20020a056102364a00b00446ff4fbfffmr574900vsu.28.1689934283786; Fri, 21 Jul
 2023 03:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-3-victorshihgli@gmail.com> <bf137a7a-9081-71ac-340f-8da09d9e63be@intel.com>
In-Reply-To: <bf137a7a-9081-71ac-340f-8da09d9e63be@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 21 Jul 2023 18:11:11 +0800
Message-ID: <CAK00qKBtYTYNB-_VHUZg72rqoxNqLBf7=TmcFSDv+jCrQBnyqw@mail.gmail.com>
Subject: Re: [PATCH V8 02/23] mmc: core: Prepare to support SD UHS-II cards
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 2:43=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 21/06/23 13:01, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Updates in V7:
> >  - Drop sd_uhs2_set_ios function.
> >  - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_up(=
).
> >  - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_off=
().
> >  - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
> >  - Modify sd_uhs2_legacy_init to avoid sd_uhs2_reinit cycle issue.
>
> This patch does not compile because it depends on definitions
> that are in patch 5.
>

Hi, Adrian

      I will fix it in the V9 version.

Thanks, Victor Shih
