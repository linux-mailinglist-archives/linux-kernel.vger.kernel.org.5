Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D23C78B4AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjH1PnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjH1Pmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:42:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EF7AC;
        Mon, 28 Aug 2023 08:42:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c0d5b16aacso17134945ad.1;
        Mon, 28 Aug 2023 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693237368; x=1693842168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+C5bm0NZ8FfX0IMc1RIzMCfp67jzgbui3vqhljIcw0=;
        b=eBV+pfUMcHdFvBtj1R1pZRwpjbFxBei2RBjb3tXqGMdkKjKnRijbfiMac4F854Me0u
         vL7mNCBH2aAr+koCEIkEgDrmnQk815kRaMm6Ns1UwAfjJrdxo2OzItdpk3RWB3Z0R1mb
         YwsUXcpAyFYi3uI82bWVDNMfdWVhoWLQNKdIpMGdDi087caEOhBYvrAOCDGpL9e87uXj
         x1jcJ0IP97/36JIiAXRVgOX4TpG/mkSABeuCS38Tz3T40K941Rz3JwZm9AWfqZmr3KN8
         2kiiFCw6LnjBnfcCsNTSldoZWemUoLWwYLWymam/ODHZqdG+ZsuuzR9bX07tJdSkphc4
         whaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693237368; x=1693842168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+C5bm0NZ8FfX0IMc1RIzMCfp67jzgbui3vqhljIcw0=;
        b=RVEk5qfgfqsZ1k/TiL0DiC3CJb98YbQmJ37OMbDpvKWmQjl44ZKXM+dvAthKuF4v4U
         +E5Zj7kifCt7qcg86TajcmsyVrtsrbtYYfLvSax/JeA1WqsaLbqcPlIm+/QqajTB3J1q
         ymUUZSysl6UuPMXNRAch71Vr3rIOE63Pq60/d/khVSYkVEPw9yXs6DjMW9HU645SfoHF
         b8n1oaykquOaAQQ/AWYJGaJHl3sRvi7eyCML9F48e5Y2Ht4GqjUi7CYKjH7SiYG4cxpI
         MegbBnFz9rpQH+pnR0zizsiM+bGXQcAf5Fs5SiEoLDNkZsH4MLaeUkqgslTTqJuvdH6V
         IH3w==
X-Gm-Message-State: AOJu0Yy72vjXsuaf9GZZMa3iCo8d4mi7qO3hefMW9ojtgsHa8FanWsG/
        a03eE65bpKU9vVf81AA5LgJkkM1zpg6yA3AbtWU=
X-Google-Smtp-Source: AGHT+IEoADliU8Y+LhDyoyKsU/g2jh3GJrlnaSheu2HHCe06lvh7hoA/Nl/ooW72FnmTpKbaloq91ODNhPX9KCFJ4gg=
X-Received: by 2002:a17:90a:df07:b0:268:5bed:708e with SMTP id
 gp7-20020a17090adf0700b002685bed708emr18391710pjb.24.1693237367775; Mon, 28
 Aug 2023 08:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <5c2913d70556b03c9bb1893c6941e8ece04934b0.1693188390.git.andreyknvl@gmail.com>
 <35c01a524b2eb6c3f01bc08f16bdff2d72256a1f.1693188390.git.andreyknvl@gmail.com>
 <24b69442-0e33-45d7-a4ed-8a8909d8c495@rowland.harvard.edu>
In-Reply-To: <24b69442-0e33-45d7-a4ed-8a8909d8c495@rowland.harvard.edu>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 28 Aug 2023 17:42:36 +0200
Message-ID: <CA+fCnZeWGXRKJzj4HCqj_K_Ouu8082HKcxLK0P1nn3j2vCQXJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: gadgetfs: return USB_GADGET_DELAYED_STATUS from setup()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     andrey.konovalov@linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Aug 28, 2023 at 4:52=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Mon, Aug 28, 2023 at 04:10:32AM +0200, andrey.konovalov@linux.dev wrot=
e:
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > Return USB_GADGET_DELAYED_STATUS from the setup() callback for 0-length
> > transfers as a workaround to stop some UDC drivers (e.g. dwc3) from
> > automatically proceeding with the status stage.
> >
> > This workaround should be removed once all UDC drivers are fixed to
> > always delay the status stage until a response is queued to EP0.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> > ---
> >  drivers/usb/gadget/legacy/inode.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/leg=
acy/inode.c
> > index 28249d0bf062..154bbf578ba2 100644
> > --- a/drivers/usb/gadget/legacy/inode.c
> > +++ b/drivers/usb/gadget/legacy/inode.c
> > @@ -31,6 +31,7 @@
> >
> >  #include <linux/usb/gadgetfs.h>
> >  #include <linux/usb/gadget.h>
> > +#include <linux/usb/composite.h>
>
> Add:  /* for USB_GADGET_DELAYED_STATUS */

Will do in v2.

> > +#undef ERROR
> >  #define ERROR(dev,fmt,args...) \
> >       xprintk(dev , KERN_ERR , fmt , ## args)
> > +#undef INFO
>
> Please move these #undef lines up, just after the new #include.  And
> add a comment explaining briefly why they are needed.

Will do in v2.

>
> Aside from these changes,
>
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Thank you, Alan!
