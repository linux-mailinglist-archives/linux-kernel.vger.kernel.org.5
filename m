Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812487C9A12
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJOQ0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjJOQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:25:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A3AB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:25:57 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d77ad095f13so3699693276.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697387156; x=1697991956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQgMATkq2MXd1DlYkpDG2LW0MTByZbFoPNJaperpgo0=;
        b=VCq3pgTad04YG+cbzFffAPlwbThPXgatsmZ1FkrW/NPImwFn94dwL4nN9fPyPRlO6U
         iczlOiw0/Ik33/cqUaD8S6bC2qTYnR0pQm/2H4b5zfX/1IqWwaxHWczz5kLKwlf0+Yek
         OyeLaCFjJ5QH0MQvbzUW+66+1fSONJcVHnmh9c4Mc2j4ps/04HkF3TtG+q0f49aDbhEK
         htiheeupdyER4IGcDJAEU6PnlhuB1XhKw8e5wU51I95jWQZLd4PC5Ecu3UCDTjTK5u25
         DwDnbb4CF8ZEFk7oadnvMfIZp6pVcx9fCdjIu4lrpwd3NnNEBbTaWkUKzzTnwmCynDqY
         AGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697387156; x=1697991956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQgMATkq2MXd1DlYkpDG2LW0MTByZbFoPNJaperpgo0=;
        b=wE+jYP+rblVHHhc6aBaOoLgDynzlLX6bfe+rEIceW9wHbwLjuI8/31FUvqkTETK7Ey
         JNkrbl+NUyxZSJkcEvYks4aWocjrlqaPuXQtjdB7uloBdGj9q2xCeG/Zs4SEG+o1Ys9L
         1TTN2PK593edeUyJha4S0qk62ytU6pmG8AYfUhHpIR81cx7qkPJrjioYiSmoG68F6Wsr
         ztJsMx53jljl1/TPlQvvakCPjd6U/pJSHYBo2aqEaSLtTUz+hGT7j4JRdWd5j9JBNkEE
         HY/4tbsX7N+o5ZXEeNpn5539wzEmjjoLxvnJdPEyacXnE1HU/VpFeMkF7CAbU2SpU16Q
         lNNw==
X-Gm-Message-State: AOJu0Yw15rLL17DwGjRnW7JnDGLDzefHLjlhpRwMzy1vRaUrfR8+5U6G
        XZbBZ9pYzk30nJaJ8lxI4h+TMiR7KITfgJq0Xtd7qmR136g=
X-Google-Smtp-Source: AGHT+IF2qK86/Tj2siScr/Uc46MXzSA5b3f1wkhIahR7xLgOtlmNztNqesmjUDm0ChPyIlSFdcpP9Hd3mqMHPjbkhac=
X-Received: by 2002:a25:4608:0:b0:d6b:1531:bc6d with SMTP id
 t8-20020a254608000000b00d6b1531bc6dmr26012732yba.30.1697387156142; Sun, 15
 Oct 2023 09:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231013002944.14607-1-edson.drosdeck@gmail.com> <2023101548-catalyze-employed-a617@gregkh>
In-Reply-To: <2023101548-catalyze-employed-a617@gregkh>
From:   edson drosdeck <edson.drosdeck@gmail.com>
Date:   Sun, 15 Oct 2023 13:35:47 -0300
Message-ID: <CAMSsBRzKnrQivTPD3zN555-gtAfKjt4ZKM0D0+BbU6TjSqHzpw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Remove unnecessary bracks
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        ruanjinjie@huawei.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

Thanks for the feedback.


Em dom., 15 de out. de 2023 =C3=A0s 13:19, Greg KH
<gregkh@linuxfoundation.org> escreveu:
>
> On Thu, Oct 12, 2023 at 09:29:44PM -0300, Edson Juliano Drosdeck wrote:
> > Warning found by checkpatch.pl script.Remove bracks than are not necess=
ary for
> > a single statement blocks in hal/odm.c
>
> "bracks"?  I think it is called "brackets", right?
>
> thanks,
>
> greg k-h
