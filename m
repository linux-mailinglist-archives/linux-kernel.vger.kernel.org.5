Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B92178093F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359550AbjHRJ7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359596AbjHRJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:58:58 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879313C21;
        Fri, 18 Aug 2023 02:58:34 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4887e66a402so144540e0c.3;
        Fri, 18 Aug 2023 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352713; x=1692957513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f6OTcYOdgYAUhtEOxfBPRyMXba0yDrUWBaWtNMpcio=;
        b=frN+Y/22BVrdQFNqFnYcNRAl9K5qUA6Ck0xVz5hUOp/LF42Wq+uBTaiEAp6qXbXUch
         Fg3nbRfcSHN5u3xB2nKcUluHZlgNxJxu0G2YxiipLCVPjfdtzokgE+gnd2jEwDBCaA1w
         pjbh4W/9bZjiI+xHQyzRLVCuieY/w87XCWIyIFMeYy+3E0TxkN0AYxdUA25zQGNjYH65
         zWXXObfsEwYAWI7FlBJwsK4fZOG/5OWdDTw8pG9M9wBg9MADJcNa028zOi7M7T+45LWi
         OL6+GMU4nKvfs0DH3nxb2vHuIFQKeqzia+dBcbpYGXbFSH4pYaFIlAIewfkPkuHPJL+U
         P5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352713; x=1692957513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5f6OTcYOdgYAUhtEOxfBPRyMXba0yDrUWBaWtNMpcio=;
        b=DjT+sigIPiFDNeIBNj6nytuoHTePEv+7bgjvHs+pui/59HPd+QrZY+ovW85Umdkbik
         7zP5ooJWum3BOVYTJYTEwXb9I/EufDu70GwAIrrK9Aaa+ROfSXzjqi+5m7QqAfn1gL/D
         u8w6WayseU+ELY3G4vcAjz2QC0Urun53K7q0eTCz2Z4EcchLzUCMJMCVyoMlFnHGkIfE
         hmC3a5CHzbEBBpmUs8zSZi4EpjX5Ig2M7uP/woLaWgRVVvwuQzGdjPQMS4DPNHfDtBEn
         peB3rI0f2yuzUPvpS81+JwWVNnCMzUDNtEVv66BqyCPShfGCTbTQILkQ19KcfX/acuQS
         JRrg==
X-Gm-Message-State: AOJu0Yx6bV+e3LSRMMhspca+ITyaJ1galTmyKsplBcygHnyiqPyK4FCG
        afYdXm2g0PzNxjGuaaKILYZd/5YAe/WN+GCtuaQ=
X-Google-Smtp-Source: AGHT+IHLCcNtQhMI1GLVJmDx+ORBBzKWNAZLyBwlM03SAzVqL2kHBDudxJeWJCN3nLVV3L+HGPp3XKh4JN28vC/SuLM=
X-Received: by 2002:a67:f1c3:0:b0:443:b014:e5af with SMTP id
 v3-20020a67f1c3000000b00443b014e5afmr2059458vsm.6.1692352713387; Fri, 18 Aug
 2023 02:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com>
 <20230721101349.12387-6-victorshihgli@gmail.com> <CAPDyKFrk+8bE+x__SGZT3YREnwGA9Vbv4V0+KYCDFjKtdWL4Pg@mail.gmail.com>
In-Reply-To: <CAPDyKFrk+8bE+x__SGZT3YREnwGA9Vbv4V0+KYCDFjKtdWL4Pg@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 18 Aug 2023 17:58:21 +0800
Message-ID: <CAK00qKBK57vSDSXa8BcX2PNdmwr6mQ5jDC9v6ZcOjdwBYZL3=w@mail.gmail.com>
Subject: Re: [PATCH V9 05/23] mmc: core: Add definitions for SD UHS-II cards
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

On Tue, Aug 8, 2023 at 6:47=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 21 Jul 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Add UHS-II specific data structures for commands and defines for
> > registers, as described in Part 1 UHS-II Addendum Version 1.01.
> >
> > UHS-II related definitions are listed below:
> >   1. UHS-II card capability: sd_uhs2_caps{}
> >   2. UHS-II configuration: sd_uhs2_config{}
> >   3. UHS-II Command structure: uhs2_command{}
> >   4. UHS-II register I/O address and register field definitions: sd_uhs=
2.h
> >
>
> I have a problem reviewing this, mainly because of one reason.
>
> That is, that you are adding things that aren't really directly
> related to the UHS-II Addendum, but rather used for how we should
> implement the UHS-II support. I suggest we drop the other parts from
> $subject patch and move them into the patch that actually needs them.
> See comments below.
>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V7:
> >  - Remove unnecessary definitions.
> >
> > Updates in V6:
> >  - Remove unnecessary definitions and functions.
> >
> > ---
> >
> >  include/linux/mmc/card.h    |  31 ++++-
> >  include/linux/mmc/core.h    |  13 ++
> >  include/linux/mmc/host.h    |  39 +++++-
> >  include/linux/mmc/sd_uhs2.h | 240 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 319 insertions(+), 4 deletions(-)
> >  create mode 100644 include/linux/mmc/sd_uhs2.h
> >
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 469fd68f854f..5cfc94b778f4 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -190,6 +190,12 @@ struct sd_switch_caps {
> >  #define SD_MAX_CURRENT_400     (1 << SD_SET_CURRENT_LIMIT_400)
> >  #define SD_MAX_CURRENT_600     (1 << SD_SET_CURRENT_LIMIT_600)
> >  #define SD_MAX_CURRENT_800     (1 << SD_SET_CURRENT_LIMIT_800)
> > +
> > +#define SD4_SET_POWER_LIMIT_0_72W      0
> > +#define SD4_SET_POWER_LIMIT_1_44W      1
> > +#define SD4_SET_POWER_LIMIT_2_16W      2
> > +#define SD4_SET_POWER_LIMIT_2_88W      3
> > +#define SD4_SET_POWER_LIMIT_1_80W      4
> >  };
> >
> >  struct sd_ext_reg {
> > @@ -213,7 +219,30 @@ struct sd_ext_reg {
> >
> >  struct sd_uhs2_config {
> >         u32                     node_id;
> > -       /* TODO: Extend with more register configs. */
> > +
> > +       u32                     n_fcu;
> > +       u32                     maxblk_len;
> > +       u8                      n_lanes;
> > +       u8                      dadr_len;
> > +       u8                      app_type;
> > +       u8                      phy_minor_rev;
> > +       u8                      phy_major_rev;
> > +       u8                      can_hibernate;
> > +       u8                      n_lss_sync;
> > +       u8                      n_lss_dir;
> > +       u8                      link_minor_rev;
> > +       u8                      link_major_rev;
> > +       u8                      dev_type;
> > +       u8                      n_data_gap;
> > +
> > +       u32                     n_fcu_set;
> > +       u32                     maxblk_len_set;
> > +       u8                      n_lanes_set;
> > +       u8                      speed_range_set;
> > +       u8                      n_lss_sync_set;
> > +       u8                      n_lss_dir_set;
> > +       u8                      n_data_gap_set;
> > +       u8                      max_retry_set;
> >  };
> >
> >  struct sdio_cccr {
> > diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> > index 6efec0b9820c..2a0581d87706 100644
> > --- a/include/linux/mmc/core.h
> > +++ b/include/linux/mmc/core.h
> > @@ -23,6 +23,14 @@ enum mmc_blk_status {
> >         MMC_BLK_NEW_REQUEST,
> >  };
> >
> > +struct uhs2_command {
> > +       u16     header;
> > +       u16     arg;
> > +       __be32  *payload;
> > +       u32     payload_len;
> > +       u32     packet_len;
> > +};
>
> Let's move this to a later patch in the series.
>

Hi, Ulf

     I will update this  in the V10 version.

Thanks, Victor Shih

> > +
> >  struct mmc_command {
> >         u32                     opcode;
> >         u32                     arg;
> > @@ -109,6 +117,11 @@ struct mmc_command {
> >         unsigned int            busy_timeout;   /* busy detect timeout =
in ms */
> >         struct mmc_data         *data;          /* data segment associa=
ted with cmd */
> >         struct mmc_request      *mrq;           /* associated request *=
/
> > +
> > +       struct uhs2_command     *uhs2_cmd;      /* UHS2 command */
> > +       u8                      *uhs2_resp;     /* UHS2 native cmd resp=
 */
> > +       u8                      uhs2_resp_len;  /* UHS2 native cmd resp=
 len */
> > +       u8                      uhs2_tmode0_flag; /* UHS2 transfer mode=
 flag */
>
> Maybe I asked this before, but why can't the uhs2_tmode0_flag be moved
> to the struct uhs2_command?
>
> Moreover, let's move these changes to a later patch in the series.
>

Hi, Ulf

     I will update this  in the V10 version.

Thanks, Victor Shih

> >  };
> >
> >  struct mmc_data {
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 6f1be9993e16..8803fe46ed24 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -16,6 +16,7 @@
> >  #include <linux/mmc/pm.h>
> >  #include <linux/dma-direction.h>
> >  #include <linux/blk-crypto-profile.h>
> > +#include <linux/mmc/sd_uhs2.h>
> >
> >  struct mmc_ios {
> >         unsigned int    clock;                  /* clock rate */
> > @@ -99,7 +100,29 @@ struct mmc_clk_phase_map {
> >  };
> >
> >  struct sd_uhs2_caps {
> > -       /* TODO: Add UHS-II capabilities for the host. */
> > +       u32     dap;
> > +       u32     gap;
> > +       u32     group_desc;
> > +       u32     maxblk_len;
> > +       u32     n_fcu;
> > +       u8      n_lanes;
> > +       u8      addr64;
> > +       u8      card_type;
> > +       u8      phy_rev;
> > +       u8      speed_range;
> > +       u8      n_lss_sync;
> > +       u8      n_lss_dir;
> > +       u8      link_rev;
> > +       u8      host_type;
> > +       u8      n_data_gap;
> > +
> > +       u32     maxblk_len_set;
> > +       u32     n_fcu_set;
> > +       u8      n_lanes_set;
> > +       u8      n_lss_sync_set;
> > +       u8      n_lss_dir_set;
> > +       u8      n_data_gap_set;
> > +       u8      max_retry_set;
> >  };
> >
> >  enum sd_uhs2_operation {
> > @@ -345,6 +368,7 @@ struct mmc_pwrseq;
> >
> >  struct mmc_supply {
> >         struct regulator *vmmc;         /* Card power supply */
> > +       struct regulator *vmmc2;        /* UHS2 VDD2 power supply */
>
> We already added vqmmc2 (below) in a previous patch, to be used for
> the VDD2 supply. This should not be needed, right?
>
> In any case, let's drop it from the $subject patch - and if needed,
> let's add it later on.
>

Hi, Ulf

     I will update this  in the V10 version.

Thanks, Victor Shih

> >         struct regulator *vqmmc;        /* Optional Vccq supply */
> >         struct regulator *vqmmc2;       /* Optional supply for phy */
> >  };
> > @@ -366,10 +390,12 @@ struct mmc_host {
> >         u32                     ocr_avail_sdio; /* SDIO-specific OCR */
> >         u32                     ocr_avail_sd;   /* SD-specific OCR */
> >         u32                     ocr_avail_mmc;  /* MMC-specific OCR */
> > +       u32                     ocr_avail_uhs2; /* UHS2-specific OCR */
>
> I doubt that we need this, but if so, let's move this to a later patch
> in the series.
>

Hi, Ulf

     I will update this  in the V10 version.

Thanks, Victor Shih

> >         struct wakeup_source    *ws;            /* Enable consume of ue=
vents */
> >         u32                     max_current_330;
> >         u32                     max_current_300;
> >         u32                     max_current_180;
> > +       u32                     max_current_180_vdd2; /* UHS2 vdd2 max =
curt. */
> >
> >  #define MMC_VDD_165_195                0x00000080      /* VDD voltage =
1.65 - 1.95 */
> >  #define MMC_VDD_20_21          0x00000100      /* VDD voltage 2.0 ~ 2.=
1 */
> > @@ -465,12 +491,13 @@ struct mmc_host {
> >  #endif
> >  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC that =
has GPT entry at a non-standard location */
> >
> > -       struct sd_uhs2_caps     uhs2_caps;      /* Host UHS-II capabili=
ties */
> > -
>
> We just added this from a previous patch in the series - and now you
> suggest moving it? Please update the original patch instead, if you
> want it to be placed somewhere else.
>

Hi, Ulf

     I will update this  in the V10 version.

Thanks, Victor Shih

> >         int flags;
> >  #define MMC_UHS2_SUPPORT (1 << 0)
> >  #define MMC_UHS2_SD_TRAN (1 << 1)
> >
> > +       bool   uhs2_app_cmd;           /* Host UHS-II APP Command */
>
> Let's move this to a later patch in the series.
>

Hi, Ulf

     I will update this  in the V10 version.

Thanks, Victor Shih

> > +       struct sd_uhs2_caps uhs2_caps; /* Host UHS-II capabilities */
> > +
> >         int                     fixed_drv_type; /* fixed driver type fo=
r non-removable media */
> >
> >         mmc_pm_flag_t           pm_caps;        /* supported pm feature=
s */
> > @@ -721,6 +748,12 @@ static inline void mmc_debugfs_err_stats_inc(struc=
t mmc_host *host,
> >         host->err_stats[stat] +=3D 1;
> >  }
> >
> > +static inline int mmc_card_uhs2_hd_mode(struct mmc_host *host)
> > +{
> > +       return host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> > +              host->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD;
> > +}
>
> Let's move this to a later patch in the series.
>

Hi, Ulf

     I will update this  in the V10 version.

Thanks, Victor Shih

> > +
> >  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)=
;
> >  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
> >  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
> > diff --git a/include/linux/mmc/sd_uhs2.h b/include/linux/mmc/sd_uhs2.h
> > new file mode 100644
> > index 000000000000..7abe9bd870c7
> > --- /dev/null
> > +++ b/include/linux/mmc/sd_uhs2.h
> > @@ -0,0 +1,240 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Header file for UHS-II packets, Host Controller registers and I/O
> > + * accessors.
> > + *
> > + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> > + */
> > +#ifndef LINUX_MMC_UHS2_H
> > +#define LINUX_MMC_UHS2_H
> > +
> > +/* LINK Layer definition */
> > +/*
> > + * UHS2 Header:
> > + * Refer to UHS-II Addendum Version 1.02 Figure 5-2, the format of CCM=
D Header is described below:
> > + *      bit [3:0]  : DID(Destination ID =3D Node ID of UHS2 card)
> > + *      bit [6:4]  : TYP(Packet Type)
> > + *                   000b: CCMD(Control command packet)
> > + *                   001b: DCMD(Data command packet)
> > + *                   010b: RES(Response packet)
> > + *                   011b: DATA(Data payload packet)
> > + *                   111b: MSG(Message packet)
> > + *                   Others: Reserved
> > + *      bit [7]    : NP(Native Packet)
> > + *      bit [10:8] : TID(Transaction ID)
> > + *      bit [11]   : Reserved
> > + *      bit [15:12]: SID(Source ID 0: Node ID of Host)
> > + *
> > + * Broadcast CCMD issued by Host is represented as DID=3DSID=3D0.
> > + */
> > +/*
> > + * UHS2 Argument:
> > + * Refer to UHS-II Addendum Version 1.02 Figure 6-5, the format of CCM=
D Argument is described below:
> > + *      bit [3:0]  : MSB of IOADR
> > + *      bit [5:4]  : PLEN(Payload Length)
> > + *                   00b: 0 byte
> > + *                   01b: 4 bytes
> > + *                   10b: 8 bytes
> > + *                   11b: 16 bytes
> > + *      bit [6]    : Reserved
> > + *      bit [7]    : R/W(Read/Write)
> > + *                   0: Control read command
> > + *                   1: Control write command
> > + *      bit [15:8] : LSB of IOADR
> > + *
> > + * I/O Address specifies the address of register in UHS-II I/O space a=
ccessed by CCMD.
> > + * The unit of I/O Address is 4 Bytes. It is transmitted in MSB first,=
 LSB last.
> > + */
> > +#define UHS2_NATIVE_PACKET_POS 7
> > +#define UHS2_NATIVE_PACKET     (1 << UHS2_NATIVE_PACKET_POS)
> > +
> > +#define UHS2_PACKET_TYPE_POS   4
> > +#define UHS2_PACKET_TYPE_CCMD  (0 << UHS2_PACKET_TYPE_POS)
> > +#define UHS2_PACKET_TYPE_DCMD  (1 << UHS2_PACKET_TYPE_POS)
> > +#define UHS2_PACKET_TYPE_RES   (2 << UHS2_PACKET_TYPE_POS)
> > +#define UHS2_PACKET_TYPE_DATA  (3 << UHS2_PACKET_TYPE_POS)
> > +#define UHS2_PACKET_TYPE_MSG   (7 << UHS2_PACKET_TYPE_POS)
> > +
> > +#define UHS2_DEST_ID_MASK      0x0F
> > +#define UHS2_DEST_ID           0x1
> > +
> > +#define UHS2_SRC_ID_POS                12
> > +#define UHS2_SRC_ID_MASK       0xF000
> > +
> > +#define UHS2_TRANS_ID_POS      8
> > +#define UHS2_TRANS_ID_MASK     0x0700
> > +
> > +/* UHS2 MSG */
> > +#define UHS2_MSG_CTG_POS       5
> > +#define UHS2_MSG_CTG_LMSG      0x00
> > +#define UHS2_MSG_CTG_INT       0x60
> > +#define UHS2_MSG_CTG_AMSG      0x80
> > +
> > +#define UHS2_MSG_CTG_FCREQ     0x00
> > +#define UHS2_MSG_CTG_FCRDY     0x01
> > +#define UHS2_MSG_CTG_STAT      0x02
> > +
> > +#define UHS2_MSG_CODE_POS                      8
> > +#define UHS2_MSG_CODE_FC_UNRECOVER_ERR         0x8
> > +#define UHS2_MSG_CODE_STAT_UNRECOVER_ERR       0x8
> > +#define UHS2_MSG_CODE_STAT_RECOVER_ERR         0x1
> > +
> > +/* TRANS Layer definition */
> > +
> > +/* Native packets*/
> > +#define UHS2_NATIVE_CMD_RW_POS 7
> > +#define UHS2_NATIVE_CMD_WRITE  (1 << UHS2_NATIVE_CMD_RW_POS)
> > +#define UHS2_NATIVE_CMD_READ   (0 << UHS2_NATIVE_CMD_RW_POS)
> > +
> > +#define UHS2_NATIVE_CMD_PLEN_POS       4
> > +#define UHS2_NATIVE_CMD_PLEN_4B                (1 << UHS2_NATIVE_CMD_P=
LEN_POS)
> > +#define UHS2_NATIVE_CMD_PLEN_8B                (2 << UHS2_NATIVE_CMD_P=
LEN_POS)
> > +#define UHS2_NATIVE_CMD_PLEN_16B       (3 << UHS2_NATIVE_CMD_PLEN_POS)
> > +
> > +#define UHS2_NATIVE_CCMD_GET_MIOADR_MASK       0xF00
> > +#define UHS2_NATIVE_CCMD_MIOADR_MASK           0x0F
> > +
> > +#define UHS2_NATIVE_CCMD_LIOADR_POS            8
> > +#define UHS2_NATIVE_CCMD_GET_LIOADR_MASK       0x0FF
> > +
> > +#define UHS2_CCMD_DEV_INIT_COMPLETE_FLAG       BIT(11)
> > +#define UHS2_DEV_INIT_PAYLOAD_LEN              1
> > +#define UHS2_DEV_INIT_RESP_LEN                 6
> > +#define UHS2_DEV_ENUM_PAYLOAD_LEN              1
> > +#define UHS2_DEV_ENUM_RESP_LEN                 8
> > +#define UHS2_CFG_WRITE_PAYLOAD_LEN             2
> > +#define UHS2_CFG_WRITE_PHY_SET_RESP_LEN                4
> > +#define UHS2_CFG_WRITE_GENERIC_SET_RESP_LEN    5
> > +#define UHS2_GO_DORMANT_PAYLOAD_LEN            1
> > +
> > +/*
> > + * UHS2 Argument:
> > + * Refer to UHS-II Addendum Version 1.02 Figure 6-8, the format of DCM=
D Argument is described below:
> > + *      bit [3:0]  : Reserved
> > + *      bit [6:3]  : TMODE(Transfer Mode)
> > + *                   bit 3: DAM(Data Access Mode)
> > + *                   bit 4: TLUM(TLEN Unit Mode)
> > + *                   bit 5: LM(Length Mode)
> > + *                   bit 6: DM(Duplex Mode)
> > + *      bit [7]    : R/W(Read/Write)
> > + *                   0: Control read command
> > + *                   1: Control write command
> > + *      bit [15:8] : Reserved
> > + *
> > + * I/O Address specifies the address of register in UHS-II I/O space a=
ccessed by CCMD.
> > + * The unit of I/O Address is 4 Bytes. It is transmitted in MSB first,=
 LSB last.
> > + */
> > +#define UHS2_DCMD_DM_POS               6
> > +#define UHS2_DCMD_2L_HD_MODE           (1 << UHS2_DCMD_DM_POS)
> > +#define UHS2_DCMD_LM_POS               5
> > +#define UHS2_DCMD_LM_TLEN_EXIST                (1 << UHS2_DCMD_LM_POS)
> > +#define UHS2_DCMD_TLUM_POS             4
> > +#define UHS2_DCMD_TLUM_BYTE_MODE       (1 << UHS2_DCMD_TLUM_POS)
> > +#define UHS2_NATIVE_DCMD_DAM_POS       3
> > +#define UHS2_NATIVE_DCMD_DAM_IO                (1 << UHS2_NATIVE_DCMD_=
DAM_POS)
> > +
> > +#define UHS2_RES_NACK_POS      7
> > +#define UHS2_RES_NACK_MASK     (0x1 << UHS2_RES_NACK_POS)
> > +
> > +#define UHS2_RES_ECODE_POS     4
> > +#define UHS2_RES_ECODE_MASK    0x7
> > +#define UHS2_RES_ECODE_COND    1
> > +#define UHS2_RES_ECODE_ARG     2
> > +#define UHS2_RES_ECODE_GEN     3
> > +
> > +/* IOADR of device registers */
> > +#define UHS2_IOADR_GENERIC_CAPS                0x00
> > +#define UHS2_IOADR_PHY_CAPS            0x02
> > +#define UHS2_IOADR_LINK_CAPS           0x04
> > +#define UHS2_IOADR_RSV_CAPS            0x06
> > +#define UHS2_IOADR_GENERIC_SETTINGS    0x08
> > +#define UHS2_IOADR_PHY_SETTINGS                0x0A
> > +#define UHS2_IOADR_LINK_SETTINGS       0x0C
> > +#define UHS2_IOADR_PRESET              0x40
> > +
> > +/* SD application packets */
> > +#define UHS2_SD_CMD_INDEX_POS  8
> > +
> > +#define UHS2_SD_CMD_APP_POS    14
> > +#define UHS2_SD_CMD_APP                (1 << UHS2_SD_CMD_APP_POS)
> > +
> > +/* UHS-II Device Registers */
> > +#define UHS2_DEV_CONFIG_REG    0x000
> > +
> > +/* General Caps and Settings registers */
> > +#define UHS2_DEV_CONFIG_GEN_CAPS       (UHS2_DEV_CONFIG_REG + 0x000)
> > +#define UHS2_DEV_CONFIG_N_LANES_POS    8
> > +#define UHS2_DEV_CONFIG_N_LANES_MASK   0x3F
> > +#define UHS2_DEV_CONFIG_2L_HD_FD       0x1
> > +#define UHS2_DEV_CONFIG_2D1U_FD                0x2
> > +#define UHS2_DEV_CONFIG_1D2U_FD                0x4
> > +#define UHS2_DEV_CONFIG_2D2U_FD                0x8
> > +#define UHS2_DEV_CONFIG_DADR_POS       14
> > +#define UHS2_DEV_CONFIG_DADR_MASK      0x1
> > +#define UHS2_DEV_CONFIG_APP_POS                16
> > +#define UHS2_DEV_CONFIG_APP_MASK       0xFF
> > +#define UHS2_DEV_CONFIG_APP_SD_MEM     0x1
> > +
> > +#define UHS2_DEV_CONFIG_GEN_SET                        (UHS2_DEV_CONFI=
G_REG + 0x008)
> > +#define UHS2_DEV_CONFIG_GEN_SET_N_LANES_POS    8
> > +#define UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD       0x0
> > +#define UHS2_DEV_CONFIG_GEN_SET_2D1U_FD                0x2
> > +#define UHS2_DEV_CONFIG_GEN_SET_1D2U_FD                0x3
> > +#define UHS2_DEV_CONFIG_GEN_SET_2D2U_FD                0x4
> > +#define UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE   BIT(31)
> > +
> > +/* PHY Caps and Settings registers */
> > +#define UHS2_DEV_CONFIG_PHY_CAPS       (UHS2_DEV_CONFIG_REG + 0x002)
> > +#define UHS2_DEV_CONFIG_PHY_MINOR_MASK 0xF
> > +#define UHS2_DEV_CONFIG_PHY_MAJOR_POS  4
> > +#define UHS2_DEV_CONFIG_PHY_MAJOR_MASK 0x3
> > +#define UHS2_DEV_CONFIG_CAN_HIBER_POS  15
> > +#define UHS2_DEV_CONFIG_CAN_HIBER_MASK 0x1
> > +#define UHS2_DEV_CONFIG_PHY_CAPS1      (UHS2_DEV_CONFIG_REG + 0x003)
> > +#define UHS2_DEV_CONFIG_N_LSS_SYN_MASK 0xF
> > +#define UHS2_DEV_CONFIG_N_LSS_DIR_POS  4
> > +#define UHS2_DEV_CONFIG_N_LSS_DIR_MASK 0xF
> > +
> > +#define UHS2_DEV_CONFIG_PHY_SET                        (UHS2_DEV_CONFI=
G_REG + 0x00A)
> > +#define UHS2_DEV_CONFIG_PHY_SET_SPEED_POS      6
> > +#define UHS2_DEV_CONFIG_PHY_SET_SPEED_A                0x0
> > +#define UHS2_DEV_CONFIG_PHY_SET_SPEED_B                0x1
> > +
> > +/* LINK-TRAN Caps and Settings registers */
> > +#define UHS2_DEV_CONFIG_LINK_TRAN_CAPS         (UHS2_DEV_CONFIG_REG + =
0x004)
> > +#define UHS2_DEV_CONFIG_LT_MINOR_MASK          0xF
> > +#define UHS2_DEV_CONFIG_LT_MAJOR_POS           4
> > +#define UHS2_DEV_CONFIG_LT_MAJOR_MASK          0x3
> > +#define UHS2_DEV_CONFIG_N_FCU_POS              8
> > +#define UHS2_DEV_CONFIG_N_FCU_MASK             0xFF
> > +#define UHS2_DEV_CONFIG_DEV_TYPE_POS           16
> > +#define UHS2_DEV_CONFIG_DEV_TYPE_MASK          0x7
> > +#define UHS2_DEV_CONFIG_MAX_BLK_LEN_POS                20
> > +#define UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK       0xFFF
> > +#define UHS2_DEV_CONFIG_LINK_TRAN_CAPS1                (UHS2_DEV_CONFI=
G_REG + 0x005)
> > +#define UHS2_DEV_CONFIG_N_DATA_GAP_MASK                0xFF
> > +
> > +#define UHS2_DEV_CONFIG_LINK_TRAN_SET          (UHS2_DEV_CONFIG_REG + =
0x00C)
> > +#define UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN     0x200
> > +#define UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS   16
> > +
> > +/* Preset register */
> > +#define UHS2_DEV_CONFIG_PRESET (UHS2_DEV_CONFIG_REG + 0x040)
> > +
> > +#define UHS2_DEV_INT_REG       0x100
> > +
> > +#define UHS2_DEV_STATUS_REG    0x180
> > +
> > +#define UHS2_DEV_CMD_REG               0x200
> > +#define UHS2_DEV_CMD_FULL_RESET                (UHS2_DEV_CMD_REG + 0x0=
00)
> > +#define UHS2_DEV_CMD_GO_DORMANT_STATE  (UHS2_DEV_CMD_REG + 0x001)
> > +#define UHS2_DEV_CMD_DORMANT_HIBER     BIT(7)
> > +#define UHS2_DEV_CMD_DEVICE_INIT       (UHS2_DEV_CMD_REG + 0x002)
> > +#define UHS2_DEV_INIT_COMPLETE_FLAG    BIT(11)
> > +#define UHS2_DEV_CMD_ENUMERATE         (UHS2_DEV_CMD_REG + 0x003)
> > +#define UHS2_DEV_CMD_TRANS_ABORT       (UHS2_DEV_CMD_REG + 0x004)
> > +
> > +#define UHS2_RCLK_MAX  52000000
> > +#define UHS2_RCLK_MIN  26000000
> > +
> > +#endif /* LINUX_MMC_UHS2_H */
>
> Kind regards
> Uffe
