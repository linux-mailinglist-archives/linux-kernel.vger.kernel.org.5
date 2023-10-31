Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E587DD281
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346507AbjJaQp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346151AbjJaQpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:45:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745E719AE;
        Tue, 31 Oct 2023 09:34:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA81C433CA;
        Tue, 31 Oct 2023 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698770066;
        bh=pZs5rfnOW3Hix1tjsUggJ963xrDWi7btCSCpkKyU+IE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bnq9Zq4I7oVJrfeOna2uSfpqtDBgo3GEXHXAOMKE1p2NcYajYMkYCKa5T7//DE0Ey
         KlXU5vJuXuCklcDHKIKUhBxIU/tH909VPN2+5eWCffOYkwVYos9YJngqj/jsYMEbmU
         +AgCo2zt6hIDFnJoHY/rmcw3P2RKZl7CQp8gjZeOPbBB1BTh/KRqttSNs70NE/EqkX
         YFjdadu5GJRTYoy4EPDP2RZ+O3NNly7Gu5obgpmbc+LLOKIdo87aJZ44o6ujdiPOG7
         vnmea9BX8UdgFTMikN6QICOiiQOtYHZXqJY80rm7Of4bLe9j+XypODv+ny3kvNgJWA
         6qrOy/YWzBeuw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-507a3b8b113so8474158e87.0;
        Tue, 31 Oct 2023 09:34:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YzmvsX+KLKnS4TbnKNHA2ImNm9j8aiO7gcLwk4sRapFHGT8r/6n
        2BKSauFFBYuL9cVQL6oxcBsvD87oNDUKMFVbuQ==
X-Google-Smtp-Source: AGHT+IEYiSmFZUL5q+DiJoXnU2ouM+e5NUrLNnjV9M4bdG4Lx26ipN+xox2BXaou74oZflON3SNBTacyhY5nekVUzyI=
X-Received: by 2002:a19:670b:0:b0:4f9:5426:6622 with SMTP id
 b11-20020a19670b000000b004f954266622mr8898618lfc.69.1698770064915; Tue, 31
 Oct 2023 09:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231030135411.776744-1-robh@kernel.org> <20231031034551.iiroxfz7qoz5r7yn@vireshk-i7>
In-Reply-To: <20231031034551.iiroxfz7qoz5r7yn@vireshk-i7>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 31 Oct 2023 11:34:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ=ceJpboLA+UjRVhSiN73RhVhh-zrUz8-Xv99LomCUjQ@mail.gmail.com>
Message-ID: <CAL_JsqJ=ceJpboLA+UjRVhSiN73RhVhh-zrUz8-Xv99LomCUjQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] opp: ti: Use device_get_match_data()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:45=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> Hmm, somehow I didn't receive the direct mail last time to my Linaro acco=
unt
> (alias of kernel.org). I do see the message being posted to LKML though.

That was an issue on my side.

>
> On 30-10-23, 08:54, Rob Herring wrote:
>
> Isn't it is compulsory to add some details in the commit log ?

Sigh, I missed adding it on this one. It should be:

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

As this driver only does DT based matching, of_match_device() will never
return NULL if we've gotten to probe(). Therefore, the NULL check and
error return for it can be dropped.

Will fix and repost.

Rob
