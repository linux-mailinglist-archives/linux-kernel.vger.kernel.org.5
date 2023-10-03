Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28DC7B674C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjJCLM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjJCLMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:12:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E80F9E;
        Tue,  3 Oct 2023 04:12:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-503065c4b25so997088e87.1;
        Tue, 03 Oct 2023 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696331539; x=1696936339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Uea/n7CBgI0sI/pNuGOUCH8+/XQkTv8PWUAIW6S7u8=;
        b=aVJY2yIPtVqglOJIBl4rde+5PACvpmFwfOrKZze453lJkae8YEyjWLQtCgfdd9DARB
         K7onloCSXoiFJSHaiSN/Uhog4Z8F5ZqRRm0IgbnC+k9OU6y01RauJXhJualdImIsIEYX
         q2Vj85kH9JoCTKYrk6cbMDWxLVo9YblIIuNJrM2uMNFQHWuFYf7G5i/0nFi/bbv8mi8M
         8NDdXO4JQ09wnik0fBKYcy51+kPsYrSXWKPpKOdPUHsV3vAZytQ7eD2Gl22SqPa4e/5h
         d/kBT0TSBu8oc1mY379VTWpkg/abhprhBS4HYw2swzQeVPQnFNzKR1xylH55sJckbFeU
         Q/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331539; x=1696936339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Uea/n7CBgI0sI/pNuGOUCH8+/XQkTv8PWUAIW6S7u8=;
        b=R7E0UM8SPDjfL4CQ+NJFMJKMxY0iyTWsy0H2PzZRfSSfn38ODWvg+KpM2tSw2OAVfN
         7zk8tunU9qF0xjW/fXHASY2mIUkuoVOrDgUcjw5/WtRIOraWUop4+UxSCtz7yX3ZIYg1
         nCZECe+2RwjXezrJd+BlDpzGapQfgafvkhJbRkU/De1Okbw1yDnf2bwdnfkOZnj7ZDs5
         MgMjeBHJ8iciN1ljbisR++7617Ajkd7MazWCsMjjJ1rNnHZrHFUXJOgGFabS/Fp/1NbW
         5+xwXALN04iJkxKnxcXUEEdI2f48uUjqXHo48aKyKT0NTK2G0mYJyaVbHefvSfO0AYUF
         xMdQ==
X-Gm-Message-State: AOJu0YxKTVE16IAz3CPr/BB+je7mhyo5jzeHb910HQxFpftl+1cIp7Tv
        iJ8CDlfpe6gU2sK31h+7/g8=
X-Google-Smtp-Source: AGHT+IGYY2nQq/lGKgQhk1UQy9uGl+2o0sgL/qWAiVCC5CIC/aEr7o/cAnve/MosSSTy6Ro66rkKcg==
X-Received: by 2002:ac2:58ca:0:b0:505:783f:bc65 with SMTP id u10-20020ac258ca000000b00505783fbc65mr6917176lfo.66.1696331539210;
        Tue, 03 Oct 2023 04:12:19 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id u7-20020ac25187000000b00505664242cbsm151495lfi.223.2023.10.03.04.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:12:18 -0700 (PDT)
Date:   Tue, 3 Oct 2023 14:12:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts handling
Message-ID: <vwdy5d3xirgioeac3mo7ditkfxevwmwmweput3xziq6tafa3zl@vtxddkiv2tux>
References: <20230923031031.21434-1-rohan.g.thomas@intel.com>
 <xwcwjtyy5yx6pruoa3vmssnjzkbeahmfyym4e5lrq2efcwwiym@2upf4ko4mah5>
 <20231002135551.020f180c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="65askapwumtpuhk6"
Content-Disposition: inline
In-Reply-To: <20231002135551.020f180c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--65askapwumtpuhk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jakub

On Mon, Oct 02, 2023 at 01:55:51PM -0700, Jakub Kicinski wrote:
> On Tue, 26 Sep 2023 14:25:56 +0300 Serge Semin wrote:
> > On Sat, Sep 23, 2023 at 11:10:31AM +0800, Rohan G Thomas wrote:
> > > Enabled the following EST related interrupts:
> > >   1) Constant Gate Control Error (CGCE)
> > >   2) Head-of-Line Blocking due to Scheduling (HLBS)
> > >   3) Head-of-Line Blocking due to Frame Size (HLBF)
> > >   4) Base Time Register error (BTRE)
> > >   5) Switch to S/W owned list Complete (SWLC)
> > > Also, add EST errors into the ethtool statistic.
> > > 
> > > The commit e49aa315cb01 ("net: stmmac: EST interrupts handling and
> > > error reporting") and commit 9f298959191b ("net: stmmac: Add EST
> > > errors into ethtool statistic") add EST interrupts handling and error
> > > reporting support to DWMAC4 core. This patch enables the same support
> > > for XGMAC.  
> > 
> > So, this is basically a copy of what was done for the DW QoS Eth
> > IP-core (DW GMAC v4.x/v5.x). IMO it would be better to factor it out
> > into a separate module together with the rest of the setup methods
> > like it's done for TC or PTP. But since it implies some much more work
> > I guess we can leave it as is for now...
> 

> I think we can push back a little harder. At the very least we should
> get a clear explanation why this copy'n'paste is needed, i.e. what are
> the major differences. No?

AFAICS there are only two firm differences between the DW QoS Eth v5.x
and DW XGMAC v3.x ESTs implementations I managed to spot from the
currently available code (My DW XGMAC _v2.11a_ HW manual doesn't have
such feature described):

1. MTL_EST_CONTROL.PTOV field offset and width: QoS [31;24], XGMAC [31;23];

2. EST CSRs base addresses: QoS 0x0c50, XGMAC 0x1050.

After the patch in subject is applied the EST config method and EST
IRQ status handlers will look almost identical except the next two
things:

1. XGMAC EST-write implementation performs atomic
MTL_EST_GCL_CONTROL.SRWO flag polling. Initially added by Jose. Not
sure whether the sleepless polling is really needed because the
stmmac_est_configure() is always called within the est->lock mutex
being taken.

2. PTP time offset setup performed by means of the
MTL_EST_CONTROL.PTOV field. DW QoS Eth v5.x HW manual claims it's "The
value of PTP Clock period multiplied by 6 in nanoseconds." So either
Jose got mistaken by using _9_ for DW XGMAC v3.x or the DW XGMAC
indeed is different in that aspect.

The rest of the differences is in the macros and functions names.
Please see the attached diff-file I collected for the EST-related code
in the DW QoS Eth v5.x and DW XGMAC v3.x modules.

Getting back to the refactoring. So basically the EST part can be
factored out in a similar way as it's done for instance for TC/PTP:

1. Define EST_GMAC4_OFFSET and EST_XGMAC_OFFSET macros in the new
header file "stmmac_est.h" (I'd prefer to drop the stmmac_-prefix but
all the sub-modules except "mmc" tends to have it).

2. Add stmmac_regs_off.est field and initialize it with the respective
offsets for the QoS and XGMAC IP-cores in the stmmac_hw static array
(hwif.c).

3. Add stmmac_priv.estaddr field and initialize it with 
(ioaddr + stmmac_regs_off.est) in the stmmac_hwif_init() function (hwif.c).

4. Define stmmac_est_ops structure in "hwif.h" with two
callbacks: .est_configure and .est_irq_status. Add the
stmmac_hwif_entry.est field of the const-pointer type to that
structure instance.

5. Redefined the stmmac_est_configure() and stmmac_est_irq_status()
macro-functions to using the callbacks from the stmmac_priv->hw->est
(hwif.h).

6. Drop the stmmac_ops.est_configure and stmmac_ops.est_irq_status.
fields (hwif.h).

7. Move all the EST-related macros to the "stmmac_est.h" file. Make
sure they are defined with EST_-prefix and the CSRs are based from
zero address since they will be utilized as the offsets for the
stmmac_priv.estaddr field.

8. Move all the EST-related functions to the new "stmmac_est.c"
module. Make sure they use the new generic EST CSRs macros and the
stmmac_priv.estaddr field as the base address of the EST CSRs. Take
into account the possible differences in the MTL_EST_CONTROL.PTOV
field initialization for the DW QoS and DW XGMAC IP-cores. Add
stmmac_est.o to stmmac-objs list in the Makefile.

9. Define stmmac_est_ops structure instance (dwmac410_est_ops) in
"stmmac_est.c" and initialize its fields with the est_configure() and
est_irq_status() functions define in 8.

10. Use the stmmac_est_ops structure instance (dwmac410_est_ops) to
initialize the stmmac_hwif_entry.est field to point to that instance
for the DW Eth QoS and DW XGMAC IP-cores.

If I didn't miss some details after that we'll have a common EST
module utilized for both DW QoS Eth and DW XGMAC IP-cores.

-Serge(y)

--65askapwumtpuhk6
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="dwmac_est.diff"

--- drivers/net/ethernet/stmicro/stmmac/dwmac5_est.c	2023-10-03 13:08:04.149201098 +0300
+++ drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core_est.c	2023-10-03 13:11:30.034936292 +0300
@@ -1,186 +1,187 @@
-#define MTL_EST_CONTROL			0x00000c50
-#define PTOV				GENMASK(31, 24)
-#define PTOV_SHIFT			24
-#define SSWL				BIT(1)
-#define EEST				BIT(0)
-
-#define MTL_EST_STATUS			0x00000c58
-#define BTRL				GENMASK(11, 8)
-#define BTRL_SHIFT			8
-#define BTRL_MAX			(0xF << BTRL_SHIFT)
-#define SWOL				BIT(7)
-#define SWOL_SHIFT			7
-#define CGCE				BIT(4)
-#define HLBS				BIT(3)
-#define HLBF				BIT(2)
-#define BTRE				BIT(1)
-#define SWLC				BIT(0)
-
-#define MTL_EST_SCH_ERR			0x00000c60
-#define MTL_EST_FRM_SZ_ERR		0x00000c64
-#define MTL_EST_FRM_SZ_CAP		0x00000c68
-#define SZ_CAP_HBFS_MASK		GENMASK(14, 0)
-#define SZ_CAP_HBFQ_SHIFT		16
-#define SZ_CAP_HBFQ_MASK(_val)	\
+#define XGMAC_MTL_EST_CONTROL		0x00001050
+#define XGMAC_PTOV			GENMASK(31, 23)
+#define XGMAC_PTOV_SHIFT		23
+#define XGMAC_SSWL			BIT(1)
+#define XGMAC_EEST			BIT(0)
+
+#define XGMAC_MTL_EST_STATUS		0x00001058
+#define XGMAC_BTRL			GENMASK(15, 8)
+#define XGMAC_BTRL_SHIFT		8
+#define XGMAC_BTRL_MAX			GENMASK(15, 8)
+#define XGMAC_CGCE			BIT(4)
+#define XGMAC_HLBS			BIT(3)
+#define XGMAC_HLBF			BIT(2)
+#define XGMAC_BTRE			BIT(1)
+#define XGMAC_SWLC			BIT(0)
+
+#define XGMAC_MTL_EST_SCH_ERR		0x00001060
+#define XGMAC_MTL_EST_FRM_SZ_ERR	0x00001064
+#define XGMAC_MTL_EST_FRM_SZ_CAP	0x00001068
+#define XGMAC_SZ_CAP_HBFS_MASK		GENMASK(14, 0)
+#define XGMAC_SZ_CAP_HBFQ_SHIFT		16
+#define XGMAC_SZ_CAP_HBFQ_MASK(val)	\
 	({					\
-		typeof(_val) (val) = (_val);	\
-		((val) > 4 ? GENMASK(18, 16) :	\
-		 (val) > 2 ? GENMASK(17, 16) :	\
+		typeof(val) _val = (val);	\
+		(_val > 4 ? GENMASK(18, 16) :	\
+		 _val > 2 ? GENMASK(17, 16) :	\
 		 BIT(16));			\
 	})
 
-#define MTL_EST_INT_EN			0x00000c70
-#define IECGCE				CGCE
-#define IEHS				HLBS
-#define IEHF				HLBF
-#define IEBE				BTRE
-#define IECC				SWLC
-
-#define MTL_EST_GCL_CONTROL		0x00000c80
-#define BTR_LOW				0x0
-#define BTR_HIGH			0x1
-#define CTR_LOW				0x2
-#define CTR_HIGH			0x3
-#define TER				0x4
-#define LLR				0x5
-#define ADDR_SHIFT			8
-#define GCRR				BIT(2)
-#define SRWO				BIT(0)
-#define MTL_EST_GCL_DATA		0x00000c84
+#define XGMAC_MTL_EST_INT_EN		0x00001070
+#define XGMAC_IECGCE			BIT(4)
+#define XGMAC_IEHS			BIT(3)
+#define XGMAC_IEHF			BIT(2)
+#define XGMAC_IEBE			BIT(1)
+#define XGMAC_IECC			BIT(0)
+
+#define XGMAC_MTL_EST_GCL_CONTROL	0x00001080
+#define XGMAC_BTR_LOW			0x0
+#define XGMAC_BTR_HIGH			0x1
+#define XGMAC_CTR_LOW			0x2
+#define XGMAC_CTR_HIGH			0x3
+#define XGMAC_TER			0x4
+#define XGMAC_LLR			0x5
+#define XGMAC_ADDR_SHIFT		8
+#define XGMAC_GCRR			BIT(2)
+#define XGMAC_SRWO			BIT(0)
+#define XGMAC_MTL_EST_GCL_DATA		0x00001084
 
-static int dwmac5_est_write(void __iomem *ioaddr, u32 reg, u32 val, bool gcl)
+static int dwxgmac3_est_write(void __iomem *ioaddr, u32 reg, u32 val, bool gcl)
 {
 	u32 ctrl;
 
-	writel(val, ioaddr + MTL_EST_GCL_DATA);
+	writel(val, ioaddr + XGMAC_MTL_EST_GCL_DATA);
 
-	ctrl = (reg << ADDR_SHIFT);
-	ctrl |= gcl ? 0 : GCRR;
+	ctrl = (reg << XGMAC_ADDR_SHIFT);
+	ctrl |= gcl ? 0 : XGMAC_GCRR;
 
-	writel(ctrl, ioaddr + MTL_EST_GCL_CONTROL);
+	writel(ctrl, ioaddr + XGMAC_MTL_EST_GCL_CONTROL);
 
-	ctrl |= SRWO;
-	writel(ctrl, ioaddr + MTL_EST_GCL_CONTROL);
+	ctrl |= XGMAC_SRWO;
+	writel(ctrl, ioaddr + XGMAC_MTL_EST_GCL_CONTROL);
 
-	return readl_poll_timeout(ioaddr + MTL_EST_GCL_CONTROL,
-				  ctrl, !(ctrl & SRWO), 100, 5000);
+	return readl_poll_timeout_atomic(ioaddr + XGMAC_MTL_EST_GCL_CONTROL,
+					 ctrl, !(ctrl & XGMAC_SRWO), 100, 5000);
 }
 
-int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
-			 unsigned int ptp_rate)
+static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
+				  unsigned int ptp_rate)
 {
 	int i, ret = 0x0;
 	u32 ctrl;
 
-	ret |= dwmac5_est_write(ioaddr, BTR_LOW, cfg->btr[0], false);
-	ret |= dwmac5_est_write(ioaddr, BTR_HIGH, cfg->btr[1], false);
-	ret |= dwmac5_est_write(ioaddr, TER, cfg->ter, false);
-	ret |= dwmac5_est_write(ioaddr, LLR, cfg->gcl_size, false);
-	ret |= dwmac5_est_write(ioaddr, CTR_LOW, cfg->ctr[0], false);
-	ret |= dwmac5_est_write(ioaddr, CTR_HIGH, cfg->ctr[1], false);
+	ret |= dwxgmac3_est_write(ioaddr, XGMAC_BTR_LOW, cfg->btr[0], false);
+	ret |= dwxgmac3_est_write(ioaddr, XGMAC_BTR_HIGH, cfg->btr[1], false);
+	ret |= dwxgmac3_est_write(ioaddr, XGMAC_TER, cfg->ter, false);
+	ret |= dwxgmac3_est_write(ioaddr, XGMAC_LLR, cfg->gcl_size, false);
+	ret |= dwxgmac3_est_write(ioaddr, XGMAC_CTR_LOW, cfg->ctr[0], false);
+	ret |= dwxgmac3_est_write(ioaddr, XGMAC_CTR_HIGH, cfg->ctr[1], false);
 	if (ret)
 		return ret;
 
 	for (i = 0; i < cfg->gcl_size; i++) {
-		ret = dwmac5_est_write(ioaddr, i, cfg->gcl[i], true);
+		ret = dwxgmac3_est_write(ioaddr, i, cfg->gcl[i], true);
 		if (ret)
 			return ret;
 	}
 
-	ctrl = readl(ioaddr + MTL_EST_CONTROL);
-	ctrl &= ~PTOV;
-	ctrl |= ((1000000000 / ptp_rate) * 6) << PTOV_SHIFT;
+	ctrl = readl(ioaddr + XGMAC_MTL_EST_CONTROL);
+	ctrl &= ~XGMAC_PTOV;
+	ctrl |= ((1000000000 / ptp_rate) * 9) << XGMAC_PTOV_SHIFT;
 	if (cfg->enable)
-		ctrl |= EEST | SSWL;
+		ctrl |= XGMAC_EEST | XGMAC_SSWL;
 	else
-		ctrl &= ~EEST;
+		ctrl &= ~XGMAC_EEST;
 
-	writel(ctrl, ioaddr + MTL_EST_CONTROL);
+	writel(ctrl, ioaddr + XGMAC_MTL_EST_CONTROL);
 
 	/* Configure EST interrupt */
 	if (cfg->enable)
-		ctrl = (IECGCE | IEHS | IEHF | IEBE | IECC);
+		ctrl = XGMAC_IECGCE | XGMAC_IEHS | XGMAC_IEHF | XGMAC_IEBE |
+			XGMAC_IECC;
 	else
 		ctrl = 0;
 
-	writel(ctrl, ioaddr + MTL_EST_INT_EN);
+	writel(ctrl, ioaddr + XGMAC_MTL_EST_INT_EN);
 
 	return 0;
 }
 
-void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
-			  struct stmmac_extra_stats *x, u32 txqcnt)
+static void dwxgmac3_est_irq_status(void __iomem *ioaddr,
+				    struct net_device *dev,
+				    struct stmmac_extra_stats *x, u32 txqcnt)
 {
 	u32 status, value, feqn, hbfq, hbfs, btrl;
-	u32 txqcnt_mask = (1 << txqcnt) - 1;
+	u32 txqcnt_mask = BIT(txqcnt) - 1;
 
-	status = readl(ioaddr + MTL_EST_STATUS);
+	status = readl(ioaddr + XGMAC_MTL_EST_STATUS);
 
-	value = (CGCE | HLBS | HLBF | BTRE | SWLC);
+	value = XGMAC_CGCE | XGMAC_HLBS | XGMAC_HLBF | XGMAC_BTRE | XGMAC_SWLC;
 
 	/* Return if there is no error */
 	if (!(status & value))
 		return;
 
-	if (status & CGCE) {
+	if (status & XGMAC_CGCE) {
 		/* Clear Interrupt */
-		writel(CGCE, ioaddr + MTL_EST_STATUS);
+		writel(XGMAC_CGCE, ioaddr + XGMAC_MTL_EST_STATUS);
 
 		x->mtl_est_cgce++;
 	}
 
-	if (status & HLBS) {
-		value = readl(ioaddr + MTL_EST_SCH_ERR);
+	if (status & XGMAC_HLBS) {
+		value = readl(ioaddr + XGMAC_MTL_EST_SCH_ERR);
 		value &= txqcnt_mask;
 
 		x->mtl_est_hlbs++;
 
 		/* Clear Interrupt */
-		writel(value, ioaddr + MTL_EST_SCH_ERR);
+		writel(value, ioaddr + XGMAC_MTL_EST_SCH_ERR);
 
 		/* Collecting info to shows all the queues that has HLBS
 		 * issue. The only way to clear this is to clear the
-		 * statistic
+		 * statistic.
 		 */
 		if (net_ratelimit())
 			netdev_err(dev, "EST: HLB(sched) Queue 0x%x\n", value);
 	}
 
-	if (status & HLBF) {
-		value = readl(ioaddr + MTL_EST_FRM_SZ_ERR);
+	if (status & XGMAC_HLBF) {
+		value = readl(ioaddr + XGMAC_MTL_EST_FRM_SZ_ERR);
 		feqn = value & txqcnt_mask;
 
-		value = readl(ioaddr + MTL_EST_FRM_SZ_CAP);
-		hbfq = (value & SZ_CAP_HBFQ_MASK(txqcnt)) >> SZ_CAP_HBFQ_SHIFT;
-		hbfs = value & SZ_CAP_HBFS_MASK;
+		value = readl(ioaddr + XGMAC_MTL_EST_FRM_SZ_CAP);
+		hbfq = (value & XGMAC_SZ_CAP_HBFQ_MASK(txqcnt)) >>
+			XGMAC_SZ_CAP_HBFQ_SHIFT;
+		hbfs = value & XGMAC_SZ_CAP_HBFS_MASK;
 
 		x->mtl_est_hlbf++;
 
 		/* Clear Interrupt */
-		writel(feqn, ioaddr + MTL_EST_FRM_SZ_ERR);
+		writel(feqn, ioaddr + XGMAC_MTL_EST_FRM_SZ_ERR);
 
 		if (net_ratelimit())
 			netdev_err(dev, "EST: HLB(size) Queue %u Size %u\n",
 				   hbfq, hbfs);
 	}
 
-	if (status & BTRE) {
-		if ((status & BTRL) == BTRL_MAX)
+	if (status & XGMAC_BTRE) {
+		if ((status & XGMAC_BTRL) == XGMAC_BTRL_MAX)
 			x->mtl_est_btrlm++;
 		else
 			x->mtl_est_btre++;
 
-		btrl = (status & BTRL) >> BTRL_SHIFT;
+		btrl = (status & XGMAC_BTRL) >> XGMAC_BTRL_SHIFT;
 
 		if (net_ratelimit())
 			netdev_info(dev, "EST: BTR Error Loop Count %u\n",
 				    btrl);
 
-		writel(BTRE, ioaddr + MTL_EST_STATUS);
+		writel(XGMAC_BTRE, ioaddr + XGMAC_MTL_EST_STATUS);
 	}
 
-	if (status & SWLC) {
-		writel(SWLC, ioaddr + MTL_EST_STATUS);
+	if (status & XGMAC_SWLC) {
+		writel(XGMAC_SWLC, ioaddr + XGMAC_MTL_EST_STATUS);
 		netdev_info(dev, "EST: SWOL has been switched\n");
 	}
 }

--65askapwumtpuhk6--
