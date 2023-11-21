Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772DA7F37C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjKUUzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjKUUzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:55:45 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ABB1BC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:55:39 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41cdc669c5eso3511cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700600139; x=1701204939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zIQA6Czlju2Y4hDlDvlKgz09FWuac93G5qYfLJq5Zs=;
        b=b5Z3y3qV5xt+VG6XUB22ObRlKWIB9C4xFWQ2zF+Rano5rEeykSO7q2Zq9Sc7HOwdag
         otrGWT/1855X0yaW1fMSdtFR95iLOjjD4HaQnHNNJ7KM1xO4KIQfNEB3POtUTdrYogko
         lP0Z20iavthGWu3vlJp4eRJFaPe7Z39QwRZ9OjQFVXq6XbX+Z1aWgyjM89I+79EeovPk
         s+23K+0P/z4ptZQNZeODKOb6xivyORxu2ZAi6ycl9R7sYMiIbQeSmhzA1u0nmQjQT+Bk
         RrKWzhZwmRw/g031oWG5B6tRvvV0fAgIULqzpqJnKDeu7Sca0nnK82lsm+rUn6/kQ8On
         406Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700600139; x=1701204939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zIQA6Czlju2Y4hDlDvlKgz09FWuac93G5qYfLJq5Zs=;
        b=VkFZQdsbGYzj7Kxac6pxsAqyVAY8oJ+X/qxgnqy0lW6EZvxQ0uF2GHCSAgH3YTqfsb
         LHw/gbNQyZsM/ucRsYlekQw8Exp0tkxD36iENXl33E5Bby9JpaHXEXUiPNkId/+D3agE
         QtUehk1NChw93uSJq1nqjGbYXD5A5dhsFH+1aCXrsSIP9qKm5tk5NW+cw1RZbX1jYDoO
         WKEDR2i0YyeQ4Mx0Hqt0FIYy1ROKlDINQghg+Kl4D9dtkZ/p/vQdHoZS5FtantMbW7tP
         9tbmb6cRnbbMwfRlHl/gmztaJFJ9lCkWosXSlaGPRCDlcSZNWBZ1kaORPw2AYEO1UaOe
         Isow==
X-Gm-Message-State: AOJu0YxnhlVUots/C5yDh6xOSiuJXSYnDKNuEKF5PGg0ortIWlGmBCiX
        B9w09u6p9p+dJ8XbQdiNqhC/5gQ4L8BrSTRrjY29cA==
X-Google-Smtp-Source: AGHT+IEvxOmwr5QH1oBTjvmPWMa36flcea+AoPT2HJGfTJnkYtMV+vgtgkV9ftPQlul7dk1JwFC/gzyDE5kcmPl4hYU=
X-Received: by 2002:ac8:58d5:0:b0:421:56ae:e761 with SMTP id
 u21-20020ac858d5000000b0042156aee761mr59846qta.6.1700600138654; Tue, 21 Nov
 2023 12:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20231121184543.3433940-1-sgzhang@google.com> <84be10f3-0880-4ccd-b6d3-b5feecea75ef@lunn.ch>
 <CAPqVEODWZ5suy7MEc_QXz_mx5uryypz1zAi9M9re-xqhs3urSA@mail.gmail.com> <ebbdf786-54d4-491c-ab81-de03006ec727@lunn.ch>
In-Reply-To: <ebbdf786-54d4-491c-ab81-de03006ec727@lunn.ch>
From:   Ray Zhang <sgzhang@google.com>
Date:   Tue, 21 Nov 2023 12:55:27 -0800
Message-ID: <CAPqVEOBeuFMAFEyiDEWg39yJ33M8U1okkJ32keOyARcXqLJW9Q@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: fix out-of-bounds read via memcpy detected
 by KASAN
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Nov 21, 2023 at 12:36=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> >     >      q0_tx_irq_n: 4
> >     >      q0_rx_pkt_n: 64
> >     >      q0_rx_irq_n: 58
> >
> >     What useful information does this list of statistics bring in the
> >     commit message?
> >
> > Each output line of "ethtool -S" is from the modified code: It shows th=
e
> > command still yields normal output results as expected.
>
> Does it? Can you actually say that looking at it?
>
Yes, I had debugging pr_err output:

[  478.894392] STMMAC_SAFETY_FEAT i=3D0, desc=3DATPES (len 6)
[  478.899709] STMMAC_SAFETY_FEAT i=3D1, desc=3DTPES (len 5)
[  478.905031] STMMAC_SAFETY_FEAT i=3D2, desc=3DRDPES (len 6)
[  478.910871] STMMAC_SAFETY_FEAT i=3D3, desc=3DMPES (len 5)
[  478.916095] STMMAC_SAFETY_FEAT i=3D4, desc=3DMTSPES (len 7)
[  478.921379] STMMAC_SAFETY_FEAT i=3D5, desc=3DARPES (len 6)
[  478.926517] STMMAC_SAFETY_FEAT i=3D6, desc=3DCWPES (len 6)
[  478.931645] STMMAC_SAFETY_FEAT i=3D7, desc=3DASRPES (len 7)
[  478.936858] STMMAC_SAFETY_FEAT i=3D8, desc=3DTTES (len 5)
[  478.942393] STMMAC_SAFETY_FEAT i=3D9, desc=3DRTES (len 5)
[  478.947845] STMMAC_SAFETY_FEAT i=3D10, desc=3DCTES (len 5)
[  478.953220] STMMAC_SAFETY_FEAT i=3D11, desc=3DATES (len 5)
[  478.958524] STMMAC_SAFETY_FEAT i=3D12, desc=3DPTES (len 5)
[  478.963828] STMMAC_SAFETY_FEAT i=3D13, desc=3DT125ES (len 7)
[  478.969224] STMMAC_SAFETY_FEAT i=3D14, desc=3DR125ES (len 7)
[  478.975814] STMMAC_SAFETY_FEAT i=3D15, desc=3DRVCTES (len 7)
[  478.981215] STMMAC_SAFETY_FEAT i=3D16, desc=3DMSTTES (len 7)
[  478.986599] STMMAC_SAFETY_FEAT i=3D17, desc=3DSLVTES (len 7)
[  478.992014] STMMAC_SAFETY_FEAT i=3D18, desc=3DATITES (len 7)
[  478.997435] STMMAC_SAFETY_FEAT i=3D19, desc=3DARITES (len 7)
[  479.003322] STMMAC_SAFETY_FEAT i=3D24, desc=3DFSMPES (len 7)
[  479.009327] STMMAC_SAFETY_FEAT i=3D32, desc=3DTXCES (len 6)
[  479.014637] STMMAC_SAFETY_FEAT i=3D33, desc=3DTXAMS (len 6)
[  479.019921] STMMAC_SAFETY_FEAT i=3D34, desc=3DTXUES (len 6)
[  479.025223] STMMAC_SAFETY_FEAT i=3D36, desc=3DRXCES (len 6)
[  479.030500] STMMAC_SAFETY_FEAT i=3D37, desc=3DRXAMS (len 6)
[  479.035792] STMMAC_SAFETY_FEAT i=3D38, desc=3DRXUES (len 6)
[  479.041669] STMMAC_SAFETY_FEAT i=3D40, desc=3DECES (len 5)
[  479.047457] STMMAC_SAFETY_FEAT i=3D41, desc=3DEAMS (len 5)
[  479.053143] STMMAC_SAFETY_FEAT i=3D42, desc=3DEUES (len 5)
[  479.058443] STMMAC_SAFETY_FEAT i=3D44, desc=3DRPCES (len 6)
[  479.063739] STMMAC_SAFETY_FEAT i=3D45, desc=3DRPAMS (len 6)
[  479.069331] STMMAC_SAFETY_FEAT i=3D46, desc=3DRPUES (len 6)
[  479.075499] STMMAC_SAFETY_FEAT i=3D64, desc=3DTCES (len 5)
[  479.080711] STMMAC_SAFETY_FEAT i=3D65, desc=3DTAMS (len 5)
[  479.086348] STMMAC_SAFETY_FEAT i=3D66, desc=3DTUES (len 5)
[  479.091573] STMMAC_MMC_STATS i=3D0, stat_string=3Dmmc_tx_octetcount_gb (=
len 21)
[  479.098852] STMMAC_MMC_STATS i=3D1, stat_string=3Dmmc_tx_framecount_gb (=
len 21)
[  479.106581] STMMAC_MMC_STATS i=3D2,
stat_string=3Dmmc_tx_broadcastframe_g (len 24)
[  479.113988] STMMAC_MMC_STATS i=3D3,
stat_string=3Dmmc_tx_multicastframe_g (len 24)
[  479.121221] STMMAC_MMC_STATS i=3D4, stat_string=3Dmmc_tx_64_octets_gb (l=
en 20)
[  479.128558] STMMAC_MMC_STATS i=3D5,
stat_string=3Dmmc_tx_65_to_127_octets_gb (len 27)
[  479.136418] STMMAC_MMC_STATS i=3D6,
stat_string=3Dmmc_tx_128_to_255_octets_gb (len 28)
[  479.144041] STMMAC_MMC_STATS i=3D7,
stat_string=3Dmmc_tx_256_to_511_octets_gb (len 28)
[  479.151663] STMMAC_MMC_STATS i=3D8,
stat_string=3Dmmc_tx_512_to_1023_octets_gb (len 29)
[  479.159495] STMMAC_MMC_STATS i=3D9,
stat_string=3Dmmc_tx_1024_to_max_octets_gb (len 29)
[  479.167255] STMMAC_MMC_STATS i=3D10, stat_string=3Dmmc_tx_unicast_gb (le=
n 18)
[  479.174755] STMMAC_MMC_STATS i=3D11, stat_string=3Dmmc_tx_multicast_gb (=
len 20)
[  479.181826] STMMAC_MMC_STATS i=3D12, stat_string=3Dmmc_tx_broadcast_gb (=
len 20)
[  479.188892] STMMAC_MMC_STATS i=3D13,
stat_string=3Dmmc_tx_underflow_error (len 23)
[  479.196211] STMMAC_MMC_STATS i=3D14, stat_string=3Dmmc_tx_singlecol_g (l=
en 19)
[  479.203783] STMMAC_MMC_STATS i=3D15, stat_string=3Dmmc_tx_multicol_g (le=
n 18)
[  479.211106] STMMAC_MMC_STATS i=3D16, stat_string=3Dmmc_tx_deferred (len =
16)
[  479.217826] STMMAC_MMC_STATS i=3D17, stat_string=3Dmmc_tx_latecol (len 1=
5)
[  479.224438] STMMAC_MMC_STATS i=3D18, stat_string=3Dmmc_tx_exesscol (len =
16)
[  479.231523] STMMAC_MMC_STATS i=3D19, stat_string=3Dmmc_tx_carrier_error =
(len 21)
[  479.239095] STMMAC_MMC_STATS i=3D20, stat_string=3Dmmc_tx_octetcount_g (=
len 20)
[  479.246178] STMMAC_MMC_STATS i=3D21, stat_string=3Dmmc_tx_framecount_g (=
len 20)
[  479.253215] STMMAC_MMC_STATS i=3D22, stat_string=3Dmmc_tx_excessdef (len=
 17)
[  479.260032] STMMAC_MMC_STATS i=3D23, stat_string=3Dmmc_tx_pause_frame (l=
en 19)
[  479.267486] STMMAC_MMC_STATS i=3D24, stat_string=3Dmmc_tx_vlan_frame_g (=
len 20)
[  479.274846] STMMAC_MMC_STATS i=3D25, stat_string=3Dmmc_rx_framecount_gb =
(len 21)
[  479.282005] STMMAC_MMC_STATS i=3D26, stat_string=3Dmmc_rx_octetcount_gb =
(len 21)
[  479.289186] STMMAC_MMC_STATS i=3D27, stat_string=3Dmmc_rx_octetcount_g (=
len 20)
[  479.296734] STMMAC_MMC_STATS i=3D28,
stat_string=3Dmmc_rx_broadcastframe_g (len 24)
[  479.304493] STMMAC_MMC_STATS i=3D29,
stat_string=3Dmmc_rx_multicastframe_g (len 24)
[  479.312253] STMMAC_MMC_STATS i=3D30, stat_string=3Dmmc_rx_crc_error (len=
 17)
[  479.319095] STMMAC_MMC_STATS i=3D31, stat_string=3Dmmc_rx_align_error (l=
en 19)
[  479.326165] STMMAC_MMC_STATS i=3D32, stat_string=3Dmmc_rx_run_error (len=
 17)
[  479.333660] STMMAC_MMC_STATS i=3D33, stat_string=3Dmmc_rx_jabber_error (=
len 20)
[  479.340771] STMMAC_MMC_STATS i=3D34, stat_string=3Dmmc_rx_undersize_g (l=
en 19)
[  479.348068] STMMAC_MMC_STATS i=3D35, stat_string=3Dmmc_rx_oversize_g (le=
n 18)
[  479.354991] STMMAC_MMC_STATS i=3D36, stat_string=3Dmmc_rx_64_octets_gb (=
len 20)
[  479.362603] STMMAC_MMC_STATS i=3D37,
stat_string=3Dmmc_rx_65_to_127_octets_gb (len 27)
[  479.370270] STMMAC_MMC_STATS i=3D38,
stat_string=3Dmmc_rx_128_to_255_octets_gb (len 28)
[  479.378296] STMMAC_MMC_STATS i=3D39,
stat_string=3Dmmc_rx_256_to_511_octets_gb (len 28)
[  479.386073] STMMAC_MMC_STATS i=3D40,
stat_string=3Dmmc_rx_512_to_1023_octets_gb (len 29)
[  479.394288] STMMAC_MMC_STATS i=3D41,
stat_string=3Dmmc_rx_1024_to_max_octets_gb (len 29)
[  479.402684] STMMAC_MMC_STATS i=3D42, stat_string=3Dmmc_rx_unicast_g (len=
 17)
[  479.409814] STMMAC_MMC_STATS i=3D43, stat_string=3Dmmc_rx_length_error (=
len 20)
[  479.416918] STMMAC_MMC_STATS i=3D44, stat_string=3Dmmc_rx_autofrangetype=
 (len 22)
[  479.424442] STMMAC_MMC_STATS i=3D45, stat_string=3Dmmc_rx_pause_frames (=
len 20)
[  479.431496] STMMAC_MMC_STATS i=3D46, stat_string=3Dmmc_rx_fifo_overflow =
(len 21)
[  479.439027] STMMAC_MMC_STATS i=3D47, stat_string=3Dmmc_rx_vlan_frames_gb=
 (len 22)
[  479.446291] STMMAC_MMC_STATS i=3D48, stat_string=3Dmmc_rx_watchdog_error=
 (len 22)
[  479.454142] STMMAC_MMC_STATS i=3D49, stat_string=3Dmmc_rx_ipc_intr_mask =
(len 21)
[  479.461296] STMMAC_MMC_STATS i=3D50, stat_string=3Dmmc_rx_ipc_intr (len =
16)
[  479.468000] STMMAC_MMC_STATS i=3D51, stat_string=3Dmmc_rx_ipv4_gd (len 1=
5)
[  479.474577] STMMAC_MMC_STATS i=3D52, stat_string=3Dmmc_rx_ipv4_hderr (le=
n 18)
[  479.481716] STMMAC_MMC_STATS i=3D53, stat_string=3Dmmc_rx_ipv4_nopay (le=
n 18)
[  479.489143] STMMAC_MMC_STATS i=3D54, stat_string=3Dmmc_rx_ipv4_frag (len=
 17)
[  479.495926] STMMAC_MMC_STATS i=3D55, stat_string=3Dmmc_rx_ipv4_udsbl (le=
n 18)
[  479.503251] STMMAC_MMC_STATS i=3D56, stat_string=3Dmmc_rx_ipv4_gd_octets=
 (len 22)
[  479.511207] STMMAC_MMC_STATS i=3D57,
stat_string=3Dmmc_rx_ipv4_hderr_octets (len 25)
[  479.519274] STMMAC_MMC_STATS i=3D58,
stat_string=3Dmmc_rx_ipv4_nopay_octets (len 25)
[  479.527106] STMMAC_MMC_STATS i=3D59,
stat_string=3Dmmc_rx_ipv4_frag_octets (len 24)
[  479.534839] STMMAC_MMC_STATS i=3D60,
stat_string=3Dmmc_rx_ipv4_udsbl_octets (len 25)
[  479.543108] STMMAC_MMC_STATS i=3D61, stat_string=3Dmmc_rx_ipv6_gd_octets=
 (len 22)
[  479.551189] STMMAC_MMC_STATS i=3D62,
stat_string=3Dmmc_rx_ipv6_hderr_octets (len 25)
[  479.558948] STMMAC_MMC_STATS i=3D63,
stat_string=3Dmmc_rx_ipv6_nopay_octets (len 25)
[  479.566482] STMMAC_MMC_STATS i=3D64, stat_string=3Dmmc_rx_ipv6_gd (len 1=
5)
[  479.573359] STMMAC_MMC_STATS i=3D65, stat_string=3Dmmc_rx_ipv6_hderr (le=
n 18)
[  479.580295] STMMAC_MMC_STATS i=3D66, stat_string=3Dmmc_rx_ipv6_nopay (le=
n 18)
[  479.587919] STMMAC_MMC_STATS i=3D67, stat_string=3Dmmc_rx_udp_gd (len 14=
)
[  479.594580] STMMAC_MMC_STATS i=3D68, stat_string=3Dmmc_rx_udp_err (len 1=
5)
[  479.601159] STMMAC_MMC_STATS i=3D69, stat_string=3Dmmc_rx_tcp_gd (len 14=
)
[  479.608608] STMMAC_MMC_STATS i=3D70, stat_string=3Dmmc_rx_tcp_err (len 1=
5)
[  479.615219] STMMAC_MMC_STATS i=3D71, stat_string=3Dmmc_rx_icmp_gd (len 1=
5)
[  479.623283] STMMAC_MMC_STATS i=3D72, stat_string=3Dmmc_rx_icmp_err (len =
16)
[  479.630368] STMMAC_MMC_STATS i=3D73, stat_string=3Dmmc_rx_udp_gd_octets =
(len 21)
[  479.637536] STMMAC_MMC_STATS i=3D74, stat_string=3Dmmc_rx_udp_err_octets=
 (len 22)
[  479.644805] STMMAC_MMC_STATS i=3D75, stat_string=3Dmmc_rx_tcp_gd_octets =
(len 21)
[  479.652646] STMMAC_MMC_STATS i=3D76, stat_string=3Dmmc_rx_tcp_err_octets=
 (len 22)
[  479.659901] STMMAC_MMC_STATS i=3D77, stat_string=3Dmmc_rx_icmp_gd_octets=
 (len 22)
[  479.667117] STMMAC_MMC_STATS i=3D78,
stat_string=3Dmmc_rx_icmp_err_octets (len 23)
[  479.674434] STMMAC_MMC_STATS i=3D79,
stat_string=3Dmmc_tx_fpe_fragment_cntr (len 25)
[  479.682463] STMMAC_MMC_STATS i=3D80, stat_string=3Dmmc_tx_hold_req_cntr =
(len 21)
[  479.689589] STMMAC_MMC_STATS i=3D81,
stat_string=3Dmmc_rx_packet_assembly_err_cntr (len 32)
[  479.698065] STMMAC_MMC_STATS i=3D82,
stat_string=3Dmmc_rx_packet_smd_err_cntr (len 27)
[  479.705703] STMMAC_MMC_STATS i=3D83,
stat_string=3Dmmc_rx_packet_assembly_ok_cntr (len 31)
[  479.714707] STMMAC_MMC_STATS i=3D84,
stat_string=3Dmmc_rx_fpe_fragment_cntr (len 25)
[  479.722188] STMMAC_STATS i=3D0, stat_string=3Dtx_underflow (len 13)
[  479.728183] STMMAC_STATS i=3D1, stat_string=3Dtx_carrier (len 11)
[  479.734050] STMMAC_STATS i=3D2, stat_string=3Dtx_losscarrier (len 15)
[  479.740197] STMMAC_STATS i=3D3, stat_string=3Dvlan_tag (len 9)
[  479.746215] STMMAC_STATS i=3D4, stat_string=3Dtx_deferred (len 12)
[  479.752119] STMMAC_STATS i=3D5, stat_string=3Dtx_vlan (len 8)
[  479.757594] STMMAC_STATS i=3D6, stat_string=3Dtx_jabber (len 10)
[  479.763319] STMMAC_STATS i=3D7, stat_string=3Dtx_frame_flushed (len 17)
[  479.769629] STMMAC_STATS i=3D8, stat_string=3Dtx_payload_error (len 17)
[  479.776479] STMMAC_STATS i=3D9, stat_string=3Dtx_ip_header_error (len 19=
)
[  479.783392] STMMAC_STATS i=3D10, stat_string=3Drx_desc (len 8)
[  479.788970] STMMAC_STATS i=3D11, stat_string=3Dsa_filter_fail (len 15)
[  479.795214] STMMAC_STATS i=3D12, stat_string=3Doverflow_error (len 15)
[  479.801703] STMMAC_STATS i=3D13, stat_string=3Dipc_csum_error (len 15)
[  479.807983] STMMAC_STATS i=3D14, stat_string=3Drx_collision (len 13)
[  479.814460] STMMAC_STATS i=3D15, stat_string=3Drx_crc_errors (len 14)
[  479.820938] STMMAC_STATS i=3D16, stat_string=3Ddribbling_bit (len 14)
[  479.827136] STMMAC_STATS i=3D17, stat_string=3Drx_length (len 10)
[  479.833604] STMMAC_STATS i=3D18, stat_string=3Drx_mii (len 7)
[  479.839619] STMMAC_STATS i=3D19, stat_string=3Drx_multicast (len 13)
[  479.846480] STMMAC_STATS i=3D20, stat_string=3Drx_gmac_overflow (len 17)
[  479.852913] STMMAC_STATS i=3D21, stat_string=3Drx_watchdog (len 12)
[  479.859240] STMMAC_STATS i=3D22, stat_string=3Dda_rx_filter_fail (len 18=
)
[  479.865760] STMMAC_STATS i=3D23, stat_string=3Dsa_rx_filter_fail (len 18=
)
[  479.872687] STMMAC_STATS i=3D24, stat_string=3Drx_missed_cntr (len 15)
[  479.879075] STMMAC_STATS i=3D25, stat_string=3Drx_overflow_cntr (len 17)
[  479.885573] STMMAC_STATS i=3D26, stat_string=3Drx_vlan (len 8)
[  479.891122] STMMAC_STATS i=3D27, stat_string=3Drx_split_hdr_pkt_n (len 1=
9)
[  479.897705] STMMAC_STATS i=3D28, stat_string=3Dtx_undeflow_irq (len 16)
[  479.904499] STMMAC_STATS i=3D29, stat_string=3Dtx_process_stopped_irq (l=
en 23)
[  479.911457] STMMAC_STATS i=3D30, stat_string=3Dtx_jabber_irq (len 14)
[  479.917897] STMMAC_STATS i=3D31, stat_string=3Drx_overflow_irq (len 16)
[  479.924268] STMMAC_STATS i=3D32, stat_string=3Drx_buf_unav_irq (len 16)
[  479.930722] STMMAC_STATS i=3D33, stat_string=3Drx_process_stopped_irq (l=
en 23)
[  479.938108] STMMAC_STATS i=3D34, stat_string=3Drx_watchdog_irq (len 16)
[  479.944518] STMMAC_STATS i=3D35, stat_string=3Dtx_early_irq (len 13)
[  479.950895] STMMAC_STATS i=3D36, stat_string=3Dfatal_bus_error_irq (len =
20)
[  479.957622] STMMAC_STATS i=3D37, stat_string=3Drx_early_irq (len 13)
[  479.964082] STMMAC_STATS i=3D38, stat_string=3Dthreshold (len 10)
[  479.970509] STMMAC_STATS i=3D39, stat_string=3Dtx_pkt_n (len 9)
[  479.976159] STMMAC_STATS i=3D40, stat_string=3Drx_pkt_n (len 9)
[  479.981799] STMMAC_STATS i=3D41, stat_string=3Dnormal_irq_n (len 13)
[  479.987917] STMMAC_STATS i=3D42, stat_string=3Drx_normal_irq_n (len 16)
[  479.994283] STMMAC_STATS i=3D43, stat_string=3Dnapi_poll (len 10)
[  480.000395] STMMAC_STATS i=3D44, stat_string=3Dtx_normal_irq_n (len 16)
[  480.006807] STMMAC_STATS i=3D45, stat_string=3Dtx_clean (len 9)
[  480.012865] STMMAC_STATS i=3D46, stat_string=3Dtx_set_ic_bit (len 14)
[  480.019043] STMMAC_STATS i=3D47, stat_string=3Dirq_receive_pmt_irq_n (le=
n 22)
[  480.026155] STMMAC_STATS i=3D48, stat_string=3Dmmc_tx_irq_n (len 13)
[  480.032833] STMMAC_STATS i=3D49, stat_string=3Dmmc_rx_irq_n (len 13)
[  480.038994] STMMAC_STATS i=3D50, stat_string=3Dmmc_rx_csum_offload_irq_n=
 (len 26)
[  480.046500] STMMAC_STATS i=3D51, stat_string=3Dirq_tx_path_in_lpi_mode_n=
 (len 26)
[  480.053710] STMMAC_STATS i=3D52,
stat_string=3Dirq_tx_path_exit_lpi_mode_n (len 28)
[  480.061074] STMMAC_STATS i=3D53, stat_string=3Dirq_rx_path_in_lpi_mode_n=
 (len 26)
[  480.068830] STMMAC_STATS i=3D54,
stat_string=3Dirq_rx_path_exit_lpi_mode_n (len 28)
[  480.076913] STMMAC_STATS i=3D55, stat_string=3Dphy_eee_wakeup_error_n (l=
en 23)
[  480.083906] STMMAC_STATS i=3D56, stat_string=3Dip_hdr_err (len 11)
[  480.089803] STMMAC_STATS i=3D57, stat_string=3Dip_payload_err (len 15)
[  480.096634] STMMAC_STATS i=3D58, stat_string=3Dip_csum_bypassed (len 17)
[  480.103087] STMMAC_STATS i=3D59, stat_string=3Dipv4_pkt_rcvd (len 14)
[  480.109499] STMMAC_STATS i=3D60, stat_string=3Dipv6_pkt_rcvd (len 14)
[  480.115679] STMMAC_STATS i=3D61, stat_string=3Dno_ptp_rx_msg_type_ext (l=
en 23)
[  480.123066] STMMAC_STATS i=3D62, stat_string=3Dptp_rx_msg_type_sync (len=
 21)
[  480.130471] STMMAC_STATS i=3D63, stat_string=3Dptp_rx_msg_type_follow_up=
 (len 26)
[  480.137685] STMMAC_STATS i=3D64, stat_string=3Dptp_rx_msg_type_delay_req=
 (len 26)
[  480.145088] STMMAC_STATS i=3D65,
stat_string=3Dptp_rx_msg_type_delay_resp (len 27)
[  480.152385] STMMAC_STATS i=3D66,
stat_string=3Dptp_rx_msg_type_pdelay_req (len 27)
[  480.160200] STMMAC_STATS i=3D67,
stat_string=3Dptp_rx_msg_type_pdelay_resp (len 28)
[  480.167581] STMMAC_STATS i=3D68,
stat_string=3Dptp_rx_msg_type_pdelay_follow_u (len 32)
[  480.175469] STMMAC_STATS i=3D69, stat_string=3Dptp_rx_msg_type_announce =
(len 25)
[  480.182632] STMMAC_STATS i=3D70,
stat_string=3Dptp_rx_msg_type_management (len 27)
[  480.190369] STMMAC_STATS i=3D71,
stat_string=3Dptp_rx_msg_pkt_reserved_type (len 29)
[  480.197842] STMMAC_STATS i=3D72, stat_string=3Dptp_frame_type (len 15)
[  480.204065] STMMAC_STATS i=3D73, stat_string=3Dptp_ver (len 8)
[  480.209614] STMMAC_STATS i=3D74, stat_string=3Dtimestamp_dropped (len 18=
)
[  480.216092] STMMAC_STATS i=3D75, stat_string=3Dav_pkt_rcvd (len 12)
[  480.222731] STMMAC_STATS i=3D76, stat_string=3Dav_tagged_pkt_rcvd (len 1=
9)
[  480.229353] STMMAC_STATS i=3D77, stat_string=3Dvlan_tag_priority_val (le=
n 22)
[  480.236491] STMMAC_STATS i=3D78, stat_string=3Dl3_filter_match (len 16)
[  480.242895] STMMAC_STATS i=3D79, stat_string=3Dl4_filter_match (len 16)
[  480.249616] STMMAC_STATS i=3D80, stat_string=3Dl3_l4_filter_no_match (le=
n 22)
[  480.256931] STMMAC_STATS i=3D81, stat_string=3Dirq_pcs_ane_n (len 14)
[  480.264320] STMMAC_STATS i=3D82, stat_string=3Dirq_pcs_link_n (len 15)
[  480.270901] STMMAC_STATS i=3D83, stat_string=3Dirq_rgmii_n (len 12)
[  480.276921] STMMAC_STATS i=3D84, stat_string=3Dmtl_tx_status_fifo_full (=
len 24)
[  480.283973] STMMAC_STATS i=3D85, stat_string=3Dmtl_tx_fifo_not_empty (le=
n 22)
[  480.291395] STMMAC_STATS i=3D86, stat_string=3Dmmtl_fifo_ctrl (len 15)
[  480.298225] STMMAC_STATS i=3D87,
stat_string=3Dmtl_tx_fifo_read_ctrl_write (len 28)
[  480.305608] STMMAC_STATS i=3D88,
stat_string=3Dmtl_tx_fifo_read_ctrl_wait (len 27)
[  480.313299] STMMAC_STATS i=3D89,
stat_string=3Dmtl_tx_fifo_read_ctrl_read (len 27)
[  480.320641] STMMAC_STATS i=3D90,
stat_string=3Dmtl_tx_fifo_read_ctrl_idle (len 27)
[  480.328459] STMMAC_STATS i=3D91, stat_string=3Dmac_tx_in_pause (len 16)
[  480.334810] STMMAC_STATS i=3D92, stat_string=3Dmac_tx_frame_ctrl_xfer (l=
en 23)
[  480.341777] STMMAC_STATS i=3D93, stat_string=3Dmac_tx_frame_ctrl_idle (l=
en 23)
[  480.349311] STMMAC_STATS i=3D94, stat_string=3Dmac_tx_frame_ctrl_wait (l=
en 23)
[  480.356688] STMMAC_STATS i=3D95, stat_string=3Dmac_tx_frame_ctrl_pause (=
len 24)
[  480.363728] STMMAC_STATS i=3D96, stat_string=3Dmac_gmii_tx_proto_engine =
(len 25)
[  480.370828] STMMAC_STATS i=3D97,
stat_string=3Dmtl_rx_fifo_fill_level_full (len 28)
[  480.378256] STMMAC_STATS i=3D98,
stat_string=3Dmtl_rx_fifo_fill_above_thresh (len 30)
[  480.386412] STMMAC_STATS i=3D99,
stat_string=3Dmtl_rx_fifo_fill_below_thresh (len 30)
[  480.393993] STMMAC_STATS i=3D100,
stat_string=3Dmtl_rx_fifo_fill_level_empty (len 29)
[  480.402512] STMMAC_STATS i=3D101,
stat_string=3Dmtl_rx_fifo_read_ctrl_flush (len 28)
[  480.410014] STMMAC_STATS i=3D102,
stat_string=3Dmtl_rx_fifo_read_ctrl_read_data (len 32)
[  480.418388] STMMAC_STATS i=3D103,
stat_string=3Dmtl_rx_fifo_read_ctrl_status (len 29)
[  480.425965] STMMAC_STATS i=3D104,
stat_string=3Dmtl_rx_fifo_read_ctrl_idle (len 27)
[  480.433324] STMMAC_STATS i=3D105, stat_string=3Dmtl_rx_fifo_ctrl_active =
(len 24)
[  480.440431] STMMAC_STATS i=3D106, stat_string=3Dmac_rx_frame_ctrl_fifo (=
len 23)
[  480.448023] STMMAC_STATS i=3D107, stat_string=3Dmac_gmii_rx_proto_engine=
 (len 25)
[  480.455226] STMMAC_STATS i=3D108, stat_string=3Dtx_tso_frames (len 14)
[  480.461458] STMMAC_STATS i=3D109, stat_string=3Dtx_tso_nfrags (len 14)
[  480.467714] STMMAC_STATS i=3D110, stat_string=3Dmtl_est_cgce (len 13)
[  480.473848] STMMAC_STATS i=3D111, stat_string=3Dmtl_est_hlbs (len 13)
[  480.480489] STMMAC_STATS i=3D112, stat_string=3Dmtl_est_hlbf (len 13)
[  480.486665] STMMAC_STATS i=3D113, stat_string=3Dmtl_est_btre (len 13)
[  480.493206] STMMAC_STATS i=3D114, stat_string=3Dmtl_est_btrlm (len 14)


> > No, since strscpy does the job already. Also I could not find ethtool_p=
uts:
> > where is it defined? Or do you mean ethtool_put_stat, which is inapprop=
riate to
> > use here since it requires a skb parameter?
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20231102-ethtool_put=
s_impl-v4-3-14e1e9278496@google.com/
>
> Maybe check with Justin when we will resend that patch.
Thanks for the link to ethtool_puts patch: Changing to use
ethtool_puts in stmmac should be in a separate patch, and not related
here.

>
>         Andrew

Ray
