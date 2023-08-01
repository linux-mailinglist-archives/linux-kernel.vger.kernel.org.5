Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8876AA6D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjHAIA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHAIAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:00:24 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F45E1729;
        Tue,  1 Aug 2023 01:00:22 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4475df91bb1so1930666137.3;
        Tue, 01 Aug 2023 01:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690876821; x=1691481621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T0bBwSwzl77NsnJjiK4EPnZtnK97qsCDrwsNw5L9Ek=;
        b=So57Ysfo0+B4yZGE1xPSR1ytBJV/m+B6Hdqc7jy/xC5nuZV+8lzvOk8b9jfFXxdCJp
         fr8q1DlFItBzb/XVi95/uWKmuVr7Q2cQx1k5Y2NGqHwAxhpO2ZifZlz9sbqEpYWAGEMR
         /1UcwBTfKtFkiqRtxJ6F0oclrR14BKZncqDZMUAZ1JbOCeRqwY8FkV4vFDFdbUgT0rMl
         LAhBGBKGz3ARYag93wXVP2czG5OZ7Vyi05BUvNNrM2oz0VX7E4VWbAsoLN7CIYtBJ9Cb
         l9nq812Li5cSa03iAEgozBxplnMMfnG4Bgz+Gh9VaP27F9jkFUW2hTm96i6SREzkQsbe
         ULow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690876821; x=1691481621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T0bBwSwzl77NsnJjiK4EPnZtnK97qsCDrwsNw5L9Ek=;
        b=ZWRnoJmV8BtcCs/0z77qyzgi8CvGtGhXT8Cm6CEd71hkj69U3FWQvwaul31CBThI7m
         Lkxp9DkKEhVt85Hlv+uG54v5pPxmN4lppm9udyvYpItHhFLgI35oSoW5HK35ur70qUtg
         lrJfDzP7C+sfuU4+lnpk29jv0rC5p9p+cTYS1yPi2aWlVE9IOE9lz19ORNNYzd4ZZl+5
         HsLSu5HXXeiFEQi4lMAEL++WK376SP9q8AdNYlqng2+kjlWu//uA44BhZuf42CcfM123
         /+4BEBR701FDAw1ZuLfN2yklWuAQNfwK4iIYOrCou0u7pQWfYg6zycyyn3mTvhuI/zHv
         KgSA==
X-Gm-Message-State: ABy/qLYmgRihkK50jHuSIR+59pBLSs3EBksgP6uI4GyqkMzs9eOvZeJQ
        ipY8J7G6J8L6D2oVwEMzqVrjXBtCSGnI7N5t8SQ=
X-Google-Smtp-Source: APBJJlEBdZqyzPz77IcelXFdLi4zFdjb3TawRjT2D9GPIgie+mf0ofORD5SvncI5Rf2yv4iFKnuiu2DMfzj7mGDHAN8=
X-Received: by 2002:a05:6102:3a57:b0:443:7935:6eb5 with SMTP id
 c23-20020a0561023a5700b0044379356eb5mr1765346vsu.15.1690876821525; Tue, 01
 Aug 2023 01:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230801045449.156348-1-zhouscd@gmail.com> <2023080159-uncorrupt-chamber-7de0@gregkh>
 <CAN4mUXNNM-25oCx1jjVqqoPpX1P8Z4zkjh84Azprz52O4_AMNw@mail.gmail.com>
 <2023080108-resilient-citation-9a34@gregkh> <CAN4mUXNZomVDfve1p_2D6G38MXd=gWLdg3=eSUMnFcWhcyb2EA@mail.gmail.com>
 <2023080152-bakeshop-shanty-2033@gregkh>
In-Reply-To: <2023080152-bakeshop-shanty-2033@gregkh>
From:   chengdong zhou <zhouscd@gmail.com>
Date:   Tue, 1 Aug 2023 16:00:10 +0800
Message-ID: <CAN4mUXP0NtrH_JUhL8NLgk7wgyMwVrdcmv_roZMkjk0DHFpjjw@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: Fix the function name error in sourcesink/loopback.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 3:35=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
>
> > > But you changed the name:
> > >
> > > > > > -     ss->function.name =3D "source/sink";
> > > > > > +     ss->function.name =3D "sourcesink";
> > >
> > > isn't that visable to userspace?
> >
> > Yes, I removed the "/". Because the macro definition
> > DECLARE_USB_FUNCTION_INIT does not support "/".
> > Should I stick with the original "SourceSink"? I think using the
> > Linux-style "sourcesink" is better. By the way, due to the current
> > bug, no one should be able to use "source/sink" in userspace.
>
> But doesn't the '/' mean that you have a subdirectory here?  What did
> userspace look like before this, and what does it look like now?
>

 Because usb_function.name and usb_function_driver.name are not the
same, this function could not be exported to userspace through the USB
config fs before. Previously, the source/sink was used by g_zero
legacy, so I will make adjustments in the next patch version by
changing the function name to "sourcesink". Do you think this is okay?
