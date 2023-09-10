Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A0799DA8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 12:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345214AbjIJKd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbjIJKdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 06:33:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C63CCC;
        Sun, 10 Sep 2023 03:33:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68cb5278e3fso702052b3a.1;
        Sun, 10 Sep 2023 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694342000; x=1694946800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YlaDIVd1Ltj5Vu8PW9TveWn/9j3kJT6S5nLrrbOFtkk=;
        b=gifsHSaZmRQS3l+uJmX5IfiLzui+xGUQoni8W+Cqjvo4jrWeH7S3H5KB0xWr1b0grs
         OI9kSJz4XX+1XAn9sE//Hvo+Oh2GmrS1Vi4WNIOW2nn86HbW/1Tow6L2jHytyxkdx2Vl
         1EW4bx3mtMSpAAS2EDQs2g4Ytc1S2PRNhNFGqrrxNJdogcF/OqUfh7y5DZUNWe8TWpDf
         H9QKK6nmXsfx9LWLvlj8zaHOTqqXS4hXVlgMKjatmiQ9q59e7v3lwU5TScoQF1zhsRI4
         /84onVtO16nipuP+1zHn1co+lgpniTPXD9oK16CWxfpOikA8PsWWoOR6n9j6/EAs7q07
         mNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694342000; x=1694946800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlaDIVd1Ltj5Vu8PW9TveWn/9j3kJT6S5nLrrbOFtkk=;
        b=RsyCXiDIju1ss/O7gws/bbN9b1HCi1Jvq69oUaCtNYDekhoCz9f28xiFs2ZxjsKH2m
         SL/wkQmA8dpjgLypQ2hh6j1jzfwmWRtcbeJY1Q73U1Tz72nNppCPdxL3vvw0hZnWXOa5
         LQaHQ0X884eJ+gKkn0/Mi1iZNrM7YiBPb6HE0GM0uyJhxl8tZYC+vpgIZJE+xfrWx23h
         NOH583+99Kdhcc3CDUVo3vTPMYELTK9ZX4BlCXPXRsKmkiKc6BiHd9kU97cS/NIx2gXg
         kGpMC568hKq3Vn+BpiaDmiEQdPu9MbC3iamJxz0JNFbyvYGQEL6e9s3DNCz4h+DoTSGa
         EdPA==
X-Gm-Message-State: AOJu0Yy8imQExhJujOT7wfkHnxvWMAtcSHOJSZDp8txhd+Wc0NStEg2z
        HSL4rDDE1I2tf970UbiEe4k1rrBljDMu3CqYrB0=
X-Google-Smtp-Source: AGHT+IEuO/lxxtIB3B4onV/HIvCnLme5ap6Un4OHKaO0LvEBhXKzjbd9+zZC6vUoTh9+4SDzBMTKTYHAneULlyeBnTk=
X-Received: by 2002:a05:6a21:194:b0:13f:65ca:52a2 with SMTP id
 le20-20020a056a21019400b0013f65ca52a2mr10373167pzb.5.1694342000174; Sun, 10
 Sep 2023 03:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230906102507.15504-2-tinozzo123@gmail.com> <CAEVj2tk3uUa625YVO+2Mv80FbNT6gE=16_GTxuLUB1ncT_jV2A@mail.gmail.com>
In-Reply-To: <CAEVj2tk3uUa625YVO+2Mv80FbNT6gE=16_GTxuLUB1ncT_jV2A@mail.gmail.com>
From:   Martino Fontana <tinozzo123@gmail.com>
Date:   Sun, 10 Sep 2023 12:33:08 +0200
Message-ID: <CAKst+mB9nm1wiPEJu1COwK422d+wbnW15Uc=s2QYD-QaP=xdGA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] HID: nintendo: reinitialize USB Pro Controller
 after resuming from suspend
To:     Daniel Ogorchock <djogorchock@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sept 2023 at 03:11, Daniel Ogorchock <djogorchock@gmail.com> wrote:
>
> Have you tested how this behaves for bluetooth controllers? Does the
> pm resume hook always result in error logs for bluetooth controllers,
> or has the kernel already removed the device before resume?

Tested on a Bluetooth connection, it behaves like it did before: the
controller disconnects as the computer sleeps, and you can have
to reconnect it by pressing a button on the controller.

I also don't see any log from that wasn't there before on journalctl.

> > +       mutex_unlock(&ctlr->output_mutex);
> > +       return 0;
>
> If desired, you could remove the above two lines and allow flow to
> continue through err_mutex even in the success case.
>
> > +
> > +err_mutex:
> > +       mutex_unlock(&ctlr->output_mutex);
> > +       return ret;
> > +}
> > +

Do I make a patch v3 for that, or is that not necessary?
(Asking because this is my first Linux kernel patch)

> >  static const struct hid_device_id nintendo_hid_devices[] = {
> >         { HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
> >                          USB_DEVICE_ID_NINTENDO_PROCON) },
> > @@ -2404,6 +2434,10 @@ static struct hid_driver nintendo_hid_driver = {
> >         .probe          = nintendo_hid_probe,
> >         .remove         = nintendo_hid_remove,
> >         .raw_event      = nintendo_hid_event,
> > +
> > +#ifdef CONFIG_PM
> > +       .resume         = nintendo_hid_resume,
> > +#endif
>
> Something else we should do is add a suspend hook to power off the
> bluetooth-connected controllers. As of now, they remain powered on
> during suspend.

No, they power off when you suspend the computer. If you press a button,
the controller will attempt to pair, just like if you disconnected it manually.
As I said before, Bluetooth behavior isn't changed.

Regards,
Martino
