Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B157BDCB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376542AbjJIMsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376284AbjJIMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:48:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA9194;
        Mon,  9 Oct 2023 05:48:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EF6C433C7;
        Mon,  9 Oct 2023 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696855702;
        bh=DVz/vrk54ln8GcE3zkgj4i2m52T14DKd91nDa8/zhCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uxBZMd/G6vNwaWndhpPYbthGH+yaeeGqaMymhy+mvuTr39vA88/53vZej/88hzXtd
         atfSCRsd/nKOhYK891jnM0p/47E1RB4rTtmwl9OIFr+r6tvuCQThRLa6Ult4ri+qib
         rINV4gRtMCmXNGfuT6ZnFS80bp60EqdikZxvZjonnhGxwdIsaMtaNy7jOYAo4m5Zn3
         EpWaWfRoT53mRK7nwpAx0+xVhSaNKugZ7RydkJGOYE85uI8N75QpYg5GeVhYHV/HRo
         eCq/PEShMx0Q67i1b4W7nUkJeY6Mp6FzErFDSXYc9ixFmhr56vhgk1ma6iCpDNCKVu
         QWJWaEjBIdOXw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5068dab8c00so2772924e87.0;
        Mon, 09 Oct 2023 05:48:22 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9GF9wPAuI+Zn+NK3tZVYO6AJY/9ZjjnOGYzvcGTiC/5wU76ve
        BOp4b0yAEcQyjXfZU0GON2hLByU5I+Mhod9zZg==
X-Google-Smtp-Source: AGHT+IFpe3AZXfMilQMsJrSH21CNnrllqJpL0cOQ7M0h4gQbm4EF/Pb+F7w7tirwUuGYzj+fqBZoeJpk/kKxVjppd2E=
X-Received: by 2002:a19:6456:0:b0:503:442:5957 with SMTP id
 b22-20020a196456000000b0050304425957mr11575125lfj.41.1696855701112; Mon, 09
 Oct 2023 05:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231006224624.444857-1-robh@kernel.org> <ZSEMLQS+9gFEAX89@yilunxu-OptiPlex-7050>
 <ZSEO5NrJl/kxd7LG@yilunxu-OptiPlex-7050>
In-Reply-To: <ZSEO5NrJl/kxd7LG@yilunxu-OptiPlex-7050>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Oct 2023 07:48:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKB4gqT06NnWj0Qkd0TuryYA15tjMSom1f+dMJfevy2Zw@mail.gmail.com>
Message-ID: <CAL_JsqKB4gqT06NnWj0Qkd0TuryYA15tjMSom1f+dMJfevy2Zw@mail.gmail.com>
Subject: Re: [PATCH] fpga: altera-ps-spi: Use spi_get_device_match_data()
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 2:56=E2=80=AFAM Xu Yilun <yilun.xu@linux.intel.com> =
wrote:
>
> On Sat, Oct 07, 2023 at 03:43:41PM +0800, Xu Yilun wrote:
> > On Fri, Oct 06, 2023 at 05:46:24PM -0500, Rob Herring wrote:
> > > Use preferred spi_get_device_match_data() instead of of_match_device(=
) and
> > > spi_get_device_id() to get the driver match data. With this, adjust t=
he
> > > includes to explicitly include the correct headers.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> >
> > Applied.
> >
> > >
> > >  static const struct spi_device_id altera_ps_spi_ids[] =3D {
> > > -   { "cyclone-ps-spi", CYCLONE5 },
> > > -   { "fpga-passive-serial", CYCLONE5 },
> > > -   { "fpga-arria10-passive-serial", ARRIA10 },
> > > +   { "cyclone-ps-spi", (uintptr_t)&c5_data },
> > > +   { "fpga-passive-serial", (uintptr_t)&c5_data },
> > > +   { "fpga-arria10-passive-serial", (uintptr_t)&a10_data },
>
> Sorry, one more. Should cast to kernel_ulong_t?

Either will work. uintptr_t is somewhat new in the kernel and
preferred now I think.

Rob
