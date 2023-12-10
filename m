Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26F80BCB4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjLJTPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJTPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:15:23 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E148CE7;
        Sun, 10 Dec 2023 11:15:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702235716; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mYG1Hl4nug3uX+70TtEtqmrM68bikeT0GCPZtJf0ZT4NjdCIGrdKNpqi0O362MSckI
    XehWyEP0Pgkt7ve2ctoCckxfW/uJzlpXuW304Ri32TiwYOFsEDgDrg1zV6gqORxM1yVv
    y5NzD18mmwiMsZrm3J8Mk1Wlrb/kVY8/mefl/iMDbRE/kifJpvFAvOHJWhRroEN7vD/K
    iVGiCJM2/1VaB65XX/mGYKX8/tseat7Vx8XSQd/OM3NqLnPU+ntow7+l68jFn/EJy2BM
    cySMiq6e0XN3O8VGYLVUlV23CZCSafabeFk37DtE1T8O/PN5W7dkCHA+kwmD8jerBbev
    lnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702235716;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kN+4pgn+X9JbSq6rnmxvpCyK4NmbIAxEf7FFl4ASmUg=;
    b=LAnrp9ce7r1GCMcECGq+H/0ne8engb8tsgOU8frm0iDa2aPP9sVvwtANAMaQkY97tR
    k99bBblO0/5KWFaMophk2+IA4OhgnlS70l6sTL1O+7pjU/Wmhll9/W1zXFtBkKWduwqF
    Ln/EuLc7QvpcGzQsjWakUHkDGtXmPSHQeaLtEUmyOVNA2kCxdMer6i83957T7UVLYqkT
    bAFmZAdYhMIWrE2OnguTL5ZVmP2IxLAsCDWpFBb2iyTysCBXqzCWyTuuyhKSuUDJdUzU
    E8sG0wQAV9/i8qi6C5gQH+kEfO+6AdLIwMUbIzBuEGD4v+1kPYEKxvqbrG2onsjj85Bg
    vmGA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702235716;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kN+4pgn+X9JbSq6rnmxvpCyK4NmbIAxEf7FFl4ASmUg=;
    b=Z2ONisAhtM2hPkYB6VN4un58UwL1jWHrT0SrJxp+b8MQzS18SBo+CnayqqcA78aFA5
    oMw/1E5Xk1+lIPslulf/ERRpR4uFF4EWBPKCvjCRsvELlQ9iZKY62hHOYOhKCxxCgTGA
    8/defd1mHEd1w9l5yeJ/HcEKS+Wsnl7+S1mug69C+fX12MQxJSjrnfmJgsBGzhD7JQoz
    76eByqT1/snAqEaYVwcEutF5emTElBgr9T1F3JHk9eBW2frWHxFfmRaUcu728G9TV/im
    9jniVVRu6xTYLmfVRfhy79lybWl5p1/yZ8xP8eBOim8Zg9D3yUUhykRz0P/98UnrvQFr
    szSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702235716;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=kN+4pgn+X9JbSq6rnmxvpCyK4NmbIAxEf7FFl4ASmUg=;
    b=GhBgKffS70zN9J5IziVGHnEJunXMrPR06F5ooW22YLSNnZwrEJtkjq/GTm93Fq+JR2
    6SokSnFc1fkBMNNJZ2BA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JyMI1zXvWpofGAS3nPdhoJ/jk9323l/f/nGBvH+kduPjVfkLDvw="
Received: from p200300c5872edccdd83ccf3bdf7838cc.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zBAJFFFQA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 10 Dec 2023 20:15:15 +0100 (CET)
Message-ID: <31f011c3d25bf63ed2b8a17ecf89f5bf70d8548c.camel@iokpp.de>
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Add UFS RTC support
From:   Bean Huo <beanhuo@iokpp.de>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikebi@micron.com, lporzio@micron.com
Date:   Sun, 10 Dec 2023 20:15:15 +0100
In-Reply-To: <20231208173118.GE15552@thinkpad>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
         <20231208103940.153734-3-beanhuo@iokpp.de>
         <20231208145021.GC15552@thinkpad>
         <89c02f8b999a90329f2125380ad2d984767d25ae.camel@iokpp.de>
         <20231208170609.GD15552@thinkpad> <20231208173118.GE15552@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-08 at 23:01 +0530, Manivannan Sadhasivam wrote:
> > >=20
> > > Thank you for your reviews. I will incorporate the suggested
> > > changes
> > > into the patch, addressing all comments except for the RTC mode
> > > switch.
> > > The proposal is to perform the RTC mode switch during UFS
> > > provisioning,
> > > not at runtime in the UFS online phase. This approach ensures
> > > that the
> > > UFS configuration is populated based on the RTC configuration
> > > established during provisioning. It is advisable not to change
> > > the RTC
> > > mode after provisioning is complete. Additionally, the usage of
> > > tv_sec,
> > > which returns time elapsed since boot, suggests that there is no
> > > issue
> > > with utilizing the RTC in this context.
> >=20
> > Except that the warning will be issued to users after each 10s for
> > 40 years.
> > Atleast get rid of that.
> >=20
>=20
> I tried this series on Qcom RB5 board and found the issue due to the
> usage of
> UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH flag. When this flag is
> set,
> ufshcd_device_init() will be called twice due to reinit of the
> controller and
> PHY.
>=20
> Since RTC work is initialized and scheduled from
> ufshcd_device_init(), panic
> happens during second time. Is it possible to move RTC init outside
> of
> ufshcd_device_init(). Maybe you can parse RTC params in
> ufshcd_device_init()
> and initialize the work elsewhere. Or you can cancel the work before
> calling
> ufshcd_device_init() second time.
>=20
> - Mani


Thank you for your review. I have moved the INIT_DELAYED_WORK(&hba-
>ufs_rtc_update_work, ufshcd_rtc_work) to ufshcd_init() from
ufs_init_rtc(). This modification has been tested on the Qcom platform.
Regarding the warning, instead of removing it entirely, I have switched
it to dev_dbg. This adjustment is made with the consideration that some
form of customer notification is still necessary.

changes as below:


diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 953d50cc4256..cb6b0c286367 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8205,7 +8205,7 @@ static void ufshcd_update_rtc(struct ufs_hba
*hba)
        ktime_get_real_ts64(&ts64);
=20
        if  (ts64.tv_sec < hba->dev_info.rtc_time_baseline) {
-               dev_warn(hba->dev, "%s: Current time precedes previous
setting!\n", __func__);
+               dev_dbg(hba->dev, "%s: Current time precedes previous
setting!\n", __func__);
                return;
        }
        /*
@@ -8270,8 +8270,6 @@ static void  ufs_init_rtc(struct ufs_hba *hba, u8
*desc_buf)
         * update work, and let user configure by sysfs node according
to specific circumstance.
         */
        hba->dev_info.rtc_update_period =3D 0;
-
-       INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
 }
=20
 static int ufs_get_device_desc(struct ufs_hba *hba)
@@ -10634,8 +10632,8 @@ int ufshcd_init(struct ufs_hba *hba, void
__iomem *mmio_base, unsigned int irq)
                                                UFS_SLEEP_PWR_MODE,
                                              =20
UIC_LINK_HIBERN8_STATE);
=20
-       INIT_DELAYED_WORK(&hba->rpm_dev_flush_recheck_work,
-                         ufshcd_rpm_dev_flush_recheck_work);
+       INIT_DELAYED_WORK(&hba->rpm_dev_flush_recheck_work,
ufshcd_rpm_dev_flush_recheck_work);
+       INIT_DELAYED_WORK(&hba->ufs_rtc_update_work, ufshcd_rtc_work);
=20
        /* Set the default auto-hiberate idle timer value to 150 ms */
        if (ufshcd_is_auto_hibern8_supported(hba) && !hba->ahit) {

Kind regards,
Bean
