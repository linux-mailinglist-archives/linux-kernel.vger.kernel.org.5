Return-Path: <linux-kernel+bounces-68453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78863857A64
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6ED2B211A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76CA51C3B;
	Fri, 16 Feb 2024 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zjT4tHbm"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B150265
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079806; cv=none; b=lbywjBL5elIXo3kMQGr7MSeX0S/s0WL7xdJZbO1hbS0TLIgseOS8Agd7mvzCD6FyS5IMmyVFMytvHTMnGncOVNmnDt+b7NvtDniPO9NDXzF1RqwD7n6lDfmv9xJl83B4pbf8L+Ulsj3HSC20rAntce/kuBcj10lK62VO5i7p9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079806; c=relaxed/simple;
	bh=R3rmQtLWD+MEUs7atLIhSmEmcg/WOo08fxQ2zNYayW4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=kXBfthyBr74+oYiADr9BnDLyZDxXH5hTp/FEpoymxibqZsLLOvVs4/keb4J/W4BRRf/HUfFIHQGJM0sQVYwXv73YfZ441cXoUa9KHvGLNqxdaZDYbVWk3xgRCW07UMs03Xcu1jIQ6lUiyk6uKefoqOYGYSpj4wJD7IB1QfFoDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zjT4tHbm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56399fb02b3so2381424a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1708079802; x=1708684602; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8j3ATOSflylkDFz4r4P2/6VN3uE3YMWUNpXVdWRu84=;
        b=zjT4tHbmwtF0DChpfZMpoAz8PFB83RL9c7odJB90BkFUEu5hnflqtZIpaG0SzdBNWV
         9Mmtle3c3GF4wK1hnmdMhkQjBNcLGT0dGzmCBqMatZvY9u7af1yKCkPxTJCNZlPN0xFS
         QjJn6MAtL88q7sFyN4axKRCZG8c1uZ5b5pVu8PmIVo/01c9Qb0FgXHwpcPIWH/nJI1wR
         bl0g7J4Z9SmoPC6dlbhnT0DMVmdOCrNL1+r/7niK4TDrKB2+JcsBBaMXpBnBUFzz1hVw
         DsJYkek7z41RuC9t3Ch/mmNTUE9uFy54dbKQAxKW/IU+oZFZFzd5mfnedArkx1617rr+
         XfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708079802; x=1708684602;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n8j3ATOSflylkDFz4r4P2/6VN3uE3YMWUNpXVdWRu84=;
        b=V8v1EpiOmPjFW88lbU3Bd/1Gn9uzpZ8KgC3vEZ+Gq/8qdiSOa1im9ZFLR5rPrYq/nr
         R4fE8DsfGxz4+yfaKCRcVNl56aK/aiyKTUWjtlFknvtsSceyyuGcTC7C7ZCVK2UQGs5l
         86TQDjWe3iy442bCHE4Vagf/pODZcq1LVcu8qvaW87Nc8gP2AloFzwJ0oP+y49h9ycEc
         A+6v2/TmLhDBcqPkYgfCXpiaw9T/UTHwr/EomaL0LWoSiSlpoOqj5mZJ5DamwGUpryTQ
         avB4E4MzeSUAx202fb+HIdjhsjOaA+5Q/2qwgvHk7+omJx8pCp3VSOX44zg824AAGf/4
         0xMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkT7GwhHXeWVdrU3C6/6orcPyPco51i4rhtgBXGlUYqtIiMGRYhkjHYQ+Rxs2IFowx0bwgqwC8Hj5XubzzNQxIG1Ko1y9MQtXcvPJQ
X-Gm-Message-State: AOJu0YzmrMABb7y4uR0XQ+RFsN4JFDdNyYjKttrG4TmAxw2bCMqoQBTN
	VnwoBLaBk6X6vslMX6z1rOZhE2RMdXAc8zXDCWnjGHaE+/inlhld5HR1UG6iDrA=
X-Google-Smtp-Source: AGHT+IHyeikDuGJsQbDAEqjUM0gsCAg7EM2qMjm2yzhSEcUmNHG/fvFEjKiI6kncNNvaGXN4Wo6gCg==
X-Received: by 2002:a05:6402:742:b0:560:8fb7:a721 with SMTP id p2-20020a056402074200b005608fb7a721mr3613039edy.13.1708079802451;
        Fri, 16 Feb 2024 02:36:42 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id l11-20020aa7c3cb000000b005640022af58sm197603edr.83.2024.02.16.02.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 02:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Feb 2024 11:36:41 +0100
Message-Id: <CZ6FR855VPP7.3GHX4EO9WEZIH@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc: "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Andy Gross"
 <agross@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bhupesh Sharma" <bhupesh.linux@gmail.com>, "David Heidelberg"
 <david@ixit.cz>, "Stephan Gerhold" <stephan@gerhold.net>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFT] arm64: dts: qcom: sm8350: Reenable crypto &
 cryptobam
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <20240108-sm8350-qce-v1-1-b7d586ff38af@fairphone.com>
 <a5923bf7-0a05-43bd-b282-b45e5653ac4d@linaro.org>
 <CY9E4ZCHOMWU.C18NR0H7V1QX@fairphone.com>
 <CAA8EJppCAMXds5F4bgeb9VJSwph-+4ekVsJ=rGib5=RR5m0DPg@mail.gmail.com>
In-Reply-To: <CAA8EJppCAMXds5F4bgeb9VJSwph-+4ekVsJ=rGib5=RR5m0DPg@mail.gmail.com>

On Mon Jan 8, 2024 at 11:45 PM CET, Dmitry Baryshkov wrote:
> On Mon, 8 Jan 2024 at 16:23, Luca Weiss <luca.weiss@fairphone.com> wrote:
> >
> > On Mon Jan 8, 2024 at 3:18 PM CET, Konrad Dybcio wrote:
> > > On 8.01.2024 14:49, Luca Weiss wrote:
> > > > When num-channels and qcom,num-ees is not provided in devicetree, t=
he
> > > > driver will try to read these values from the registers during prob=
e but
> > > > this fails if the interconnect is not on and then crashes the syste=
m.
> > > >
> > > > So we can provide these properties in devicetree (queried after pat=
ching
> > > > BAM driver to enable the necessary interconnect) so we can probe
> > > > cryptobam without reading registers and then also use the QCE as
> > > > expected.
> > >
> > > This really feels a bit backwards.. Enable the resource to query the
> > > hardware for numbers, so that said resource can be enabled, but
> > > slightly later :/
> >
> > If you think adding interconnect support to driver and dtsi is better,
> > let me know.
>
> I'd say, adding the proper interconnect is a better option. Otherwise
> we just depend on the QCE itself to set up the vote for us.

Yes, currently we depend on that.

>
> >
> > Stephan (+CC) mentioned it should be okay like this *shrug*
> >
> > For the record, this is the same way I got the values for sc7280[0] and
> > sm6350[1].
> >
> > [0] https://lore.kernel.org/linux-arm-msm/20231229-sc7280-cryptobam-fix=
up-v1-1-bd8f68589b80@fairphone.com/
> > [1] https://lore.kernel.org/linux-arm-msm/20240105-sm6350-qce-v1-0-416e=
5c7319ac@fairphone.com/
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts=
/qcom/sm8350.dtsi
> > index b46236235b7f..cd4dd9852d9e 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > @@ -1756,8 +1756,8 @@ cryptobam: dma-controller@1dc4000 {
> >                         qcom,controlled-remotely;
> >                         iommus =3D <&apps_smmu 0x594 0x0011>,
> >                                  <&apps_smmu 0x596 0x0011>;
> > -                       /* FIXME: Probing BAM DMA causes some abort and=
 system hang */
> > -                       status =3D "fail";
> > +                       interconnects =3D <&aggre2_noc MASTER_CRYPTO 0 =
&mc_virt SLAVE_EBI1 0>;
> > +                       interconnect-names =3D "memory";
> >                 };
> >
> >                 crypto: crypto@1dfa000 {
> > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > index 5e7d332731e0..9de28f615639 100644
> > --- a/drivers/dma/qcom/bam_dma.c
> > +++ b/drivers/dma/qcom/bam_dma.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/circ_buf.h>
> >  #include <linux/clk.h>
> >  #include <linux/dmaengine.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/pm_runtime.h>
> >
> >  #include "../dmaengine.h"
> > @@ -394,6 +395,7 @@ struct bam_device {
> >         const struct reg_offset_data *layout;
> >
> >         struct clk *bamclk;
> > +       struct icc_path *mem_path;
> >         int irq;
> >
> >         /* dma start transaction tasklet */
> > @@ -1206,6 +1208,7 @@ static int bam_init(struct bam_device *bdev)
> >                 bdev->num_channels =3D val & BAM_NUM_PIPES_MASK;
> >         }
> >
> > +       printk(KERN_ERR "%s:%d DBG num_ees=3D%u num_channels=3D%u\n", _=
_func__, __LINE__, bdev->num_ees, bdev->num_channels);
> >         /* Reset BAM now if fully controlled locally */
> >         if (!bdev->controlled_remotely && !bdev->powered_remotely)
> >                 bam_reset(bdev);
> > @@ -1298,6 +1301,14 @@ static int bam_dma_probe(struct platform_device =
*pdev)
> >                 return ret;
> >         }
> >
> > +       bdev->mem_path =3D devm_of_icc_get(bdev->dev, "memory");
> > +       if (IS_ERR(bdev->mem_path))
> > +               return PTR_ERR(bdev->mem_path);
> > +
> > +       ret =3D icc_set_bw(bdev->mem_path, 1, 1);
>
> Probably this needs some more sensible value.

So downstream qcedev driver uses 384 for the interconnect. But this is
crypto-specific and probably different BAMs have different minimum
requirements?

#define CRYPTO_AVG_BW			384
#define CRYPTO_PEAK_BW			384
https://github.com/xiaomi-sm8450-kernel/android_kernel_platform_msm-kernel/=
blob/lineage-20/drivers/crypto/msm/qce.h#L57

Do you have any suggestion what to use here?

Also I'd assume that with pm_runtime suspended we'd need to clear the
votes in the driver so we don't keep the interconnect alive
unnecessarily?

If someone wants to pick up that patch, I'd be very glad since
especially for sm8350 this is just a drive-by, I don't care too much
about the SoC myself ;)

Regards
Luca

>
> > +       if (ret)
> > +               return ret;
> > +
> >         ret =3D bam_init(bdev);
> >         if (ret)
> >                 goto err_disable_clk;
> >


