Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEDE753868
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjGNKkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbjGNKkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:40:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED83030C6;
        Fri, 14 Jul 2023 03:40:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b898cfa6a1so2578925ad.1;
        Fri, 14 Jul 2023 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689331219; x=1689936019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xEDvEshWz1yLfwD9ujMq6u1dhcjZzxsYm3tldqUCaJg=;
        b=PJwEwUwTcyhVlqm5m+fjjVZJi6DHyPZ800OIPwrNRBlRtX4R8NmGjj3UXx/SMrV+bd
         +rzjNBh1bFxJTn6I+uT33ZmkJt8EmLLdCnpjT5Tn43eFOAD23vHPWvzrNwm2nHEC52RQ
         J/lTvPf+Ft0deFph+PptEtKngJDCnKwXpPvMiuNEPIDOfXYp/SSmQPdv2huth6n+eMlt
         AEBE+zpb4nlWbh9usBkNY+KBIAwEex5GC1BnRTvZJCVgzAiWNML5nozwq+xC5RNbEf4U
         +D8CxoAO/aio6e2HKuOOQy+rXKIOmMUm6HB5k7Z2W2019tOnhwaqNeGRnohzmVL73Nnp
         wP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689331219; x=1689936019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEDvEshWz1yLfwD9ujMq6u1dhcjZzxsYm3tldqUCaJg=;
        b=PvMskFkfCqm/Hy05oIje41xNWXlIkz3lmYvMmR07rEtfuRXKvUkwp1prYCsfnN1gXN
         1vJ27BpK+NDT+LgL6vwFlatln99q5HZYM9cHf5PNcB5O/Y1GYHpYGmIjnVwXZZETf67s
         rkoxl51Qh+AQeVwGtpUobGTvAz1RAGOkfXmoQXJgc6cgUNFCZiaFxQBFOaqhzswteUPT
         vyBO8STQ+lbOnhfPzX+xGtX44RL/VYNe7pUmIDaYN/SJ8n009fc3VyGM813nDfhKjOba
         NDIWHTIKkiHCE6ITC8JqvP4ZcUFUnDIkpJ/EPG9u8w8JOMCheNB9sNuYuCOUaXj7b0Wr
         SUKA==
X-Gm-Message-State: ABy/qLZ+algGqz1W2X2SZOLhQwQ8qVbYXE2otrdJK5zqs6hio+5M4t+H
        k4nRAA0NLvzLl5TNe91jNRM=
X-Google-Smtp-Source: APBJJlGNFfi53nBm44csakJXJfNszrKQItvcaUdZ7UQT1F7ZYhpRu8aoOyDW/O1UpnOlDfRgvbptFw==
X-Received: by 2002:a17:902:d508:b0:1b8:17e8:547e with SMTP id b8-20020a170902d50800b001b817e8547emr5433870plg.1.1689331219280;
        Fri, 14 Jul 2023 03:40:19 -0700 (PDT)
Received: from mail.google.com (125-237-52-155-fibre.sparkbb.co.nz. [125.237.52.155])
        by smtp.gmail.com with ESMTPSA id ix13-20020a170902f80d00b001b896686c78sm7472188plb.66.2023.07.14.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:40:18 -0700 (PDT)
Date:   Fri, 14 Jul 2023 22:40:12 +1200
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alexander.deucher@amd.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: replace 1-element arrays with flexible arrays
Message-ID: <ZLEmDBfklhfGCLGa@mail.google.com>
References: <20230712083137.1080883-1-ricardo.canuelo@collabora.com>
 <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OUS=JDfCdrCsuzTB0xD5yeX7piEDEqkRO-ffPTFVYs3g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:12:08AM -0400, Alex Deucher wrote:
> On Wed, Jul 12, 2023 at 8:04 AM Ricardo Cañuelo
> <ricardo.canuelo@collabora.com> wrote:
> >
> > UBSAN complains about out-of-bounds array indexes on all 1-element
> > arrays defined on this driver:
> >
> > UBSAN: array-index-out-of-bounds in /home/rcn/work/repos/kernelci/kernelci-core/linux_kernel_mainline/drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/processpptables.c:1249:61
> >
> > Substitute them with proper flexible arrays.
> 

Hi Ricardo,

thanks for your patch! when submitting patches regarding flex-arrays
please cc linux-hardening@vger.kernel.org too :-)

I added my considerations in-line.

> + Gustavo, Paulo
> 
> I haven't kept up with the flexible arrays stuff.  Is this equivalent
> to a zero sized array?  We've been bitten by these kind of changes in
> the past.  These structures define the layout of data in a rom image
> on the board.  If the struct size changes, that could lead to errors
> in the code that deals with these structures.
> 
> Alex

Hi Alex,

correct, both zero-sized and one-sized arrays (in some contexts)
are deprecated [1] and being replaced with flexible arrays as part of the 
kernel self protection project (KSSP) led by Kees Cook and Gustavo Silva.

Converting away from them can be tricky, and I think such conversions need
to explicitly show how they were checked for binary differences[2].

Ricardo, can you please check for deltas and report your findings in the
commit log?

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
[2] https://outflux.net/blog/archives/2022/06/24/finding-binary-differences/

> 
> >
> > Tested on an Acer R721T (grunt) Chromebook.
> >
> > Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> > ---
> >  drivers/gpu/drm/amd/include/pptable.h | 36 +++++++++++++++------------
> >  1 file changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
> > index 0b6a057e0a4c..a65e2807dc06 100644
> > --- a/drivers/gpu/drm/amd/include/pptable.h
> > +++ b/drivers/gpu/drm/amd/include/pptable.h
> > @@ -473,14 +473,14 @@ typedef struct _ATOM_PPLIB_STATE_V2
> >        /**
> >        * Driver will read the first ucNumDPMLevels in this array
> >        */
> > -      UCHAR clockInfoIndex[1];
> > +      __DECLARE_FLEX_ARRAY(UCHAR, clockInfoIndex);

_All_ references of __DECLARE_FLEX_ARRAY in this patch should be replaced
with DECLARE_FLEX_ARRAY macro (without __).

While they converge to the same code today, __DECLARE_FLEX_ARRAY macro
is specific for UAPI while DECLARE_FLEX_ARRAY isn't as seen in this
patch:

https://github.com/torvalds/linux/commit/3080ea5553cc909b000d1f1d964a9041962f2c5b

> >  } ATOM_PPLIB_STATE_V2;
> >
[... snip for brevity ]
> >
> >  typedef struct _VCEClockInfo{
> > @@ -581,7 +585,7 @@ typedef struct _VCEClockInfo{
> >
> >  typedef struct _VCEClockInfoArray{
> >      UCHAR ucNumEntries;
> > -    VCEClockInfo entries[1];
> > +    __DECLARE_FLEX_ARRAY(VCEClockInfo, entries);
> >  }VCEClockInfoArray;

this would cause a binary difference if the driver code used sizeof().

Currently, the source code is calculating the struct size manually at

drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c:86

  86 static uint16_t get_vce_clock_info_array_size(struct pp_hwmgr *hwmgr,
  87                         const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
  88 {
  89         uint16_t table_offset = get_vce_clock_info_array_offset(hwmgr,
  90                                                         powerplay_table);
  91         uint16_t table_size = 0;
  92 
  93         if (table_offset > 0) {
  94                 const VCEClockInfoArray *p = (const VCEClockInfoArray *)
  95                         (((unsigned long) powerplay_table) + table_offset);
  96                 table_size = sizeof(uint8_t) + p->ucNumEntries * sizeof(VCEClockInfo);
  97         }
  98 
  99         return table_size;
 100 }

 Ricardo, please replace table_size assigment with struct_size(p, entries, p->ucNumEntries)

> >
> >  typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
> > @@ -593,7 +597,7 @@ typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record
> >  typedef struct _ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table
> >  {
> >      UCHAR numEntries;
> > -    ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record entries[1];
> > +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record, entries);
> >  }ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table;

similar situation as above.. needs struct_size

drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c:115

 115 static uint16_t get_vce_clock_voltage_limit_table_size(struct pp_hwmgr *hwmgr,
 116                                                         const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 117 {
 118         uint16_t table_offset = get_vce_clock_voltage_limit_table_offset(hwmgr, powerplay_table);
 119         uint16_t table_size = 0;
 120
 121         if (table_offset > 0) {
 122                 const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *ptable =
 123                         (const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *)(((unsigned long) powerplay_table) + table_offset);
 124
 125                 table_size = sizeof(uint8_t) + ptable->numEntries * sizeof(ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record);
 126         }
 127         return table_size;
 128 }

> >
> >  typedef struct _ATOM_PPLIB_VCE_State_Record
> > @@ -605,7 +609,7 @@ typedef struct _ATOM_PPLIB_VCE_State_Record
> >  typedef struct _ATOM_PPLIB_VCE_State_Table
> >  {
> >      UCHAR numEntries;
> > -    ATOM_PPLIB_VCE_State_Record entries[1];
> > +    __DECLARE_FLEX_ARRAY(ATOM_PPLIB_VCE_State_Record, entries);
> >  }ATOM_PPLIB_VCE_State_Table;
> >
> >
> >

On drivers/gpu/drm/amd/pm/legacy-dpm:420, there are many references that
are calculated manually and could possibly benefit from this
housekeeping patch about flex arrays.

In most cases, changing the struct like you did would create binary
differences but given the way that this driver was implemented, they can
slip through the cracks and make those lines more cryptic and
subsequently, less likely to be fixed in the future....

my 2 cents would be to tidy this up alongside the struct changes whether
that's in the same patch or a series of patches.

 420                         VCEClockInfoArray *array = (VCEClockInfoArray *)
 421                                 (mode_info->atom_context->bios + data_offset +
 422                                  le16_to_cpu(ext_hdr->usVCETableOffset) + 1);
 423                         ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *limits =
 424                                 (ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *)
 425                                 (mode_info->atom_context->bios + data_offset +
 426                                  le16_to_cpu(ext_hdr->usVCETableOffset) + 1 +
 427                                  1 + array->ucNumEntries * sizeof(VCEClockInfo));
 428                         ATOM_PPLIB_VCE_State_Table *states =
 429                                 (ATOM_PPLIB_VCE_State_Table *)
 430                                 (mode_info->atom_context->bios + data_offset +
 431                                  le16_to_cpu(ext_hdr->usVCETableOffset) + 1 +
 432                                  1 + (array->ucNumEntries * sizeof (VCEClockInfo)) +
 433                                  1 + (limits->numEntries * sizeof(ATOM_PPLIB_VCE_Clock_Voltage_Limit_Record)));


> >  #pragma pack()
> > --
> > 2.25.1
> >

I didn't review all struct changes but I reckon that you got the train
of thought to be followed by now. Please count on me for reviewing those
changes :-)

Thanks!

- Paulo A.

