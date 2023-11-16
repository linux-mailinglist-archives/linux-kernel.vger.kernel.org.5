Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7367EDB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjKPFUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjKPFUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:20:02 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428D119D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:19:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so4260a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700111997; x=1700716797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGYprdScTqWADbZjmkaUNZP95viu5EuGZmBuv/KDyEs=;
        b=xHj/ry9quiFe7fFr7/dcD75iH42lyO22uCdiMwK7cJc4K4eYTyNdgSo66xyf7lB4u/
         ukGQSUvVNki35wS8gH+P2SwTYjyPxAsnm8YbBgFIo2sfeIPlozbLM+IwR2/r82saYhme
         nYRaGvFg9Xm9aLI1nIxRzk3LBf7Fnoc1j1+X+qiHZ6YLn9bNfJ+v4QlDA3Ic+AiGH/XU
         bq4BsWTMLZe0xrtPCpbULcKmoJ5pDqP9pZ75br2pA+0ukXGRPqt6CiY64hwAfEtVoos9
         AGSW1LfkpwARMLIYQIRNJnH9rL20I7X66jQhXC/kfaFP/B99da4hrLWB4RFgjcHSYP/C
         STTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700111997; x=1700716797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGYprdScTqWADbZjmkaUNZP95viu5EuGZmBuv/KDyEs=;
        b=mAcXAhA3yHehZfyoSA6C9eRJlS1wWWtKJf1KEzziDZYuNK6Ilv2HZDVSFSRk9c+53G
         73RKWCaLmA2zmipvV942txtcMBQHwdRQwS8kdnVkzZAdBkqyf843WMFuvZfRC0Mst6fk
         xlnadXssD8H/P90Rd9KpJoAk08m5LClRJMEOPS3BU/5Mo2owQ7d6BZn7QPiQF533se7I
         ayBRnySGLPVYZUdBIglh5FBOcWUOi7sc3U6hkix4grU5CJLklNeW1P2ycNVaGxntJ8K5
         pAlz7b1jt7XV4bMhfWL1vJxIb/+xpNADnBZL6daEK1BhB9CkIFEtx6qyStMtUM6AvQBw
         Gbrw==
X-Gm-Message-State: AOJu0YywEUbNZnSLV9W3g/G8pWQ82345Alkho96NIWg+52+YT34AoBvR
        FIyD0heffug68DWL2VhBs+NoPyUkfxnpACkhwFUHEw==
X-Google-Smtp-Source: AGHT+IE0jGwich417SoKNosePdtNllvU6BPMZJ2AvjLtmwsojkI2cUVJSxChDYvpfOsmQdGRjaRt0sjFc65ofzF6pdU=
X-Received: by 2002:aa7:c592:0:b0:545:2921:d217 with SMTP id
 g18-20020aa7c592000000b005452921d217mr68226edq.6.1700111997441; Wed, 15 Nov
 2023 21:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20231102073840.1579540-1-maurora@google.com> <20231110230837.b5q5dsvsqlxfz5xu@synopsys.com>
In-Reply-To: <20231110230837.b5q5dsvsqlxfz5xu@synopsys.com>
From:   Manan Aurora <maurora@google.com>
Date:   Thu, 16 Nov 2023 10:49:44 +0530
Message-ID: <CAJnM4-wew9b=Ge8QHLRiReNJAqgA0ngOW8WTVk4frta+y+9jYw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "badhri@google.com" <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 4:39=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> On Thu, Nov 02, 2023, Manan Aurora wrote:
> > Support configuration and use of bulk endpoints in the so-called EBC
> > mode described in the DBC_usb31 databook (appendix E)
> >
> > Added a bit fifo_mode to usb_ep to indicate to the UDC driver that a
> > specific endpoint is to operate in the EBC (or equivalent) mode when
> > enabled
>
> This should be unique to dwc3, and it's only for bulk. I don't think
> usb_ep or the user of usb_ep should know this.

In our use case we have a function driver that configures an allocated bulk
endpoint to operate as an EBC EP. So the function driver already depends on=
 the
feature.

dwc3_ep seems like the correct place to put this field but a function
driver that allocates
EPs and configures them for this use case would need to include dwc3 header=
s.
If other vendors offer an equivalent feature this dependency would
become an issue.

Exporting a symbol from dwc3 is an easy option but dwc3 doesn't
currently export symbols
hence I tried to avoid that

> Also since DWC3_DEPCFG_EBC_HWO_NOWB must be set, the controller does not
> write back to the TRB. Did you handle how the driver would update the
> usb request on completion? (e.g. how much was transferred).

In our use case, we intend to have a link TRB and issue a startXfer
command. Completion
handling and continuing the transfer will be offloaded to dedicated
FIFO hardware.
But we can definitely rework this to disable no-writeback mode by
default and allow this to
be separately enabled

>
> BR,
> Thinh
>
> >
> > Added macros for bits 15 and 14 of DEPCFG parameter 1 to indicate EBC
> > mode and write back behaviour. These bits will be set to 1 when
> > configuring an EBC endpoint as described in the programming guide
> >
> > Signed-off-by: Manan Aurora <maurora@google.com>
> > ---
> >  drivers/usb/dwc3/core.h    | 1 +
> >  drivers/usb/dwc3/gadget.c  | 6 ++++++
> >  drivers/usb/dwc3/gadget.h  | 2 ++
> >  include/linux/usb/gadget.h | 4 ++++
> >  4 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index efe6caf4d0e8..c5b578188cd3 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -374,6 +374,7 @@
> >  /* Global HWPARAMS4 Register */
> >  #define DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(n) (((n) & (0x0f << 13)) >> =
13)
> >  #define DWC3_MAX_HIBER_SCRATCHBUFS           15
> > +#define DWC3_EXT_BUFF_CONTROL                BIT(21)
> >
> >  /* Global HWPARAMS6 Register */
> >  #define DWC3_GHWPARAMS6_BCSUPPORT            BIT(14)
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 858fe4c299b7..47d2737d528b 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -673,6 +673,12 @@ static int dwc3_gadget_set_ep_config(struct dwc3_e=
p *dep, unsigned int action)
> >               params.param1 |=3D DWC3_DEPCFG_BINTERVAL_M1(bInterval_m1)=
;
> >       }
> >
> > +     if (dep->endpoint.fifo_mode) {
> > +             if (!(dwc->hwparams.hwparams4 & DWC3_EXT_BUFF_CONTROL))
> > +                     return -EINVAL;
> > +             params.param1 |=3D DWC3_DEPCFG_EBC_HWO_NOWB | DWC3_DEPCFG=
_USE_EBC;
> > +     }
> > +
> >       return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &par=
ams);
> >  }
> >
> > diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
> > index 55a56cf67d73..fd7a4e94397e 100644
> > --- a/drivers/usb/dwc3/gadget.h
> > +++ b/drivers/usb/dwc3/gadget.h
> > @@ -26,6 +26,8 @@ struct dwc3;
> >  #define DWC3_DEPCFG_XFER_NOT_READY_EN        BIT(10)
> >  #define DWC3_DEPCFG_FIFO_ERROR_EN    BIT(11)
> >  #define DWC3_DEPCFG_STREAM_EVENT_EN  BIT(13)
> > +#define DWC3_DEPCFG_EBC_HWO_NOWB     BIT(14)
> > +#define DWC3_DEPCFG_USE_EBC          BIT(15)
> >  #define DWC3_DEPCFG_BINTERVAL_M1(n)  (((n) & 0xff) << 16)
> >  #define DWC3_DEPCFG_STREAM_CAPABLE   BIT(24)
> >  #define DWC3_DEPCFG_EP_NUMBER(n)     (((n) & 0x1f) << 25)
> > diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> > index 6532beb587b1..c526ae09bcee 100644
> > --- a/include/linux/usb/gadget.h
> > +++ b/include/linux/usb/gadget.h
> > @@ -209,6 +209,9 @@ struct usb_ep_caps {
> >   *   by this EP (0 - 16, actual number is 2^n)
> >   * @mult: multiplier, 'mult' value for SS Isoc EPs
> >   * @maxburst: the maximum number of bursts supported by this EP (for u=
sb3)
> > + * @fifo_mode: indicates that the control of this EP is handed off to =
an
> > + *   hardware fifo device. Depends on hardware support eg. EBC feature
> > + *   of DWC usb3.1 device or equivalent. Set before enabling the EP
> >   * @driver_data:for use by the gadget driver.
> >   * @address: used to identify the endpoint when finding descriptor tha=
t
> >   *   matches connection speed
> > @@ -236,6 +239,7 @@ struct usb_ep {
> >       unsigned                max_streams:16;
> >       unsigned                mult:2;
> >       unsigned                maxburst:5;
> > +     unsigned                fifo_mode:1;
> >       u8                      address;
> >       const struct usb_endpoint_descriptor    *desc;
> >       const struct usb_ss_ep_comp_descriptor  *comp_desc;
> > --
> > 2.42.0.820.g83a721a137-goog
> >
