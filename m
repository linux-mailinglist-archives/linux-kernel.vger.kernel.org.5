Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA797EB65E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjKNS14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjKNS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:27:54 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43E3B8;
        Tue, 14 Nov 2023 10:27:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699986459; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mzUaepfHhzXgDeJKxkzqqhgWKiGR4TxvBnIvqh865ge4WBNYl0BfIyEGcc1qfCfMnW
    T9rhaaM/bbxo2KCknbLFiCXrRA5FghIEo9bA7idXpXiqFKb8g6aVCqz76604Rjkzgg/M
    hLLqZ/uPf+AqfDzjnH4vmmibtYl3ukDfVQShiOcHhf2XpwPu8tIMra2f4yHkj4O2c6P+
    9vTEwqcM4eW6mCT9mjfKv5D8A9oLI1ryWGc/pvpt0eFwUs68+bVuius7Ob/omSy4fU/N
    w8XQdWGlV9kc8fyGIt8ZAENZtsG7ipzkmqmR5rZPZ68eROlLpYr/CLS+jgPkwGAH1e3w
    Cs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699986459;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4Fhd9W6J/FtHQb3eqvYxGekeP1iAWCQi63b2vIat1w0=;
    b=qhX8OGKxnwgIOdWmhxCU6UegTVHzZCpXdKJjJEyXgR0aQts78FRI8hDwQzy+R4qB6o
    nZ16JIBA94xKMyiSc3DOX0JFPmEI+8WgzU98PqtzF9+bbafQU6UnQMwj2CJiPY4ttQ4l
    ma/ra9rr8bg6igz2TDMSXwfmO3u1sq9960Z5VQTko+ossgTo2oZHxy7YBxVLTbEXHJQY
    gfIVp1zt/iIehJ3KNh3QXIMlgI0zQzXky1VexowvOZrm0l9nErts7Dczzh2rwu+jnk8a
    +SAwIeO4olDiOfKAdIYxxfa2hRiTgBh4Yzn54FSZg8DjODSEBaFSdpg6BuHmROIYwEh+
    7P+g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699986459;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4Fhd9W6J/FtHQb3eqvYxGekeP1iAWCQi63b2vIat1w0=;
    b=ovAo1WP0thWJyLYpyf0ZOtDxDlSoneEG4XXdY/FM1OJOFzGT+LMyqwMexwmPvEymb2
    KgTLaSz1iQsVXCt5M8GtzzIp+4Oc2KFNUJeTeeanIZh3x9MoPkjpSM/mJngLxCoThcFp
    BYw6rINitFfKJSs2TxTXwCdFLr13wyyXd81BA6F9k/vtrQdD0APp50zuigT8luesryOf
    AH8KFr84+Yx4FDM3RsuvtvOhQfe1PC30ALjVbSi79q/t7s/sEqW/YBSSuBYz/K7gWc1x
    Gk+uQFbAMosziq1ySjRBn3bMGkpxJxPwHgUmj+PtVWsi4f6ct8WxWyOBNO7F/Y2Xdp07
    FRnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699986459;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4Fhd9W6J/FtHQb3eqvYxGekeP1iAWCQi63b2vIat1w0=;
    b=G783veHrx+NScB8fyeyZgWUR5XBAVMv3j6BTLYsbDIPykBlPXu+M5eFGK45aH6jPf9
    MjsOA/eDOuCg/WoVdbCg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
Received: from [10.176.235.177]
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id z758a5zAEIRcV7n
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 14 Nov 2023 19:27:38 +0100 (CET)
Message-ID: <e408ce14d322223c1412efa46e8e4d30f44fa98c.camel@iokpp.de>
Subject: Re: [PATCH v1 1/2] scsi: ufs: core: Add UFS RTC support
From:   Bean Huo <beanhuo@iokpp.de>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, mani@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
Date:   Tue, 14 Nov 2023 19:27:37 +0100
In-Reply-To: <e2e77da5-c344-4913-a321-4cfdcc4a3915@t-8ch.de>
References: <20231109125217.185462-1-beanhuo@iokpp.de>
         <20231109125217.185462-2-beanhuo@iokpp.de>
         <e2e77da5-c344-4913-a321-4cfdcc4a3915@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thank you for your review. I will resolve the highlighted issue in the
upcoming version.=C2=A0Two separate questions that require individual
answers as below:=20


On Thu, 2023-11-09 at 15:05 +0100, Thomas Wei=C3=9Fschuh wrote:
> > =C2=A0 static int ufs_get_device_desc(struct ufs_hba *hba)
> > =C2=A0 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> > @@ -8237,6 +8321,8 @@ static int ufs_get_device_desc(struct ufs_hba
> > *hba)
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ufshcd_temp_notif_probe=
(hba, desc_buf);
> > =C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ufs_init_rtc(hba, desc_buf);
> > +
>=20
> As somebody with no idea and no access to the specs:
>=20
> Is this available for all devices and all protocol versions?
>=20
> >=20
I would like to mention that while I cannot confirm that RTC works on
all protocol versions, it has been consistently functional on all
devices in the market since the introduction of UFS 2.0, which also
introduced RTC. I am not aware of any UFS version lower than 2.0
currently available on the market. In the event that a vendor has a
product with a lower UFS version, we can consider implementing a
version check.

> >=20
> >=20

> >=20
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> > =C2=A0=20
> > =C2=A0 set_link_active:
> > @@ -9840,6 +9930,8 @@ static int __ufshcd_wl_resume(struct ufs_hba
> > *hba, enum ufs_pm_op pm_op)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
goto set_old_link_state;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ufshcd_set_timestamp_attr(hba);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0msecs_to_ji
> > ffies(UFS_RTC_UPDATE_EVERY_MS));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ufshcd_keep_autobko=
ps_enabled_except_suspend(hba))
> > diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> > index e77ab1786856..18b39c6b3a97 100644
> > --- a/include/ufs/ufs.h
> > +++ b/include/ufs/ufs.h
> > @@ -14,6 +14,7 @@
> > =C2=A0 #include <linux/bitops.h>
> > =C2=A0 #include <linux/types.h>
> > =C2=A0 #include <uapi/scsi/scsi_bsg_ufs.h>
> > +#include <linux/rtc.h>
>=20
> Seems unnecessary.

seems it's needed, otherwise, I will get:
./include/ufs/ufs.h:599:9: error: unknown type name =E2=80=98time64_t=E2=80=
=99


Kind regards,
Bean

