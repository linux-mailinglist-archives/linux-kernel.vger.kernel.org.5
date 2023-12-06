Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D0980662F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 05:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376617AbjLFEbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 23:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFEbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 23:31:10 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9388C1BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 20:31:13 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ce32821a53so2158210b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 20:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701837073; x=1702441873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfeQxumI0PHw0UwdzP2daWYbnp5sISbogIw9MPq84jk=;
        b=ZtgeNBZenh9WI6MRBSyMA13AZc24U7SvfzXPslTy4kkQXgfEZYz/EqYYjgt4jDF/HZ
         6driuYOOn3nvXmjU4XaqUzLhkha2q4nHbBnWaLf+12fgbvE+RLl9V2z1Po9nmeozbjjC
         75sD9J5MYoQb5mnGT9/ytkANBYKRDP86mCB+yUD4CnDE62ufJXmCHErlqhUump1lgJ+h
         rRS2/5BLGXuNbIJDFp39384r2q5Ev9ziIsU3XEvp/J6uq8S+mqoz0cIK8pwxHmx6n6FS
         5BoEa/CoauWCZSkOwQWd47y9YZqqkFGhWs57IK/8oh5HmlcwbhKDuv1TvxZjCZd1bhZR
         BY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701837073; x=1702441873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfeQxumI0PHw0UwdzP2daWYbnp5sISbogIw9MPq84jk=;
        b=SqLcojKiwvP+zdZK3/EswgwyDQuOiemsh5SKCR67RJiUrXDayopJVAXIaatmbhmR8a
         j35N/jgkzqsYbdauK19YyTrg0Yc8sHPMETFWz0+86hs60Qi7tSS4PkfWbbS8qD/Oa3qa
         oIhmv5ZwMCHoCaAC/A1UfFk77lXk4fexXfL9KUslF8obrkcaTETHd4lONRSSWN2Adzkh
         cQI8diD3tH2cD4NC1Zx/7JDXKbtbPT5y3keU7oOUlijm0ajrUqXV2RUceeVIjv0euFqJ
         Tuz2Za8zdHyxPP2vCgdk44pBC7kehx1GiC+5grn19Hm8DMRdQBbq8g+GBw4ELZi+V3iT
         WvxQ==
X-Gm-Message-State: AOJu0YyRZWEmhXeMnHamx3bBPT6WN4TquMVVMmlrO+czt/FWtfv1SqKC
        D7JKNXHHPh4nrfm737JN3KKO
X-Google-Smtp-Source: AGHT+IEI9FCS2feasSxWKI37Bacq7XeUiz42xYyRt1InJH++Ohc+d7zUMVqrILOB310SErWFRUZGKQ==
X-Received: by 2002:a05:6a00:2d23:b0:6ce:2731:c234 with SMTP id fa35-20020a056a002d2300b006ce2731c234mr158444pfb.35.1701837072898;
        Tue, 05 Dec 2023 20:31:12 -0800 (PST)
Received: from thinkpad ([117.202.188.104])
        by smtp.gmail.com with ESMTPSA id s24-20020a62e718000000b006ce6b0d76d1sm2257266pfh.69.2023.12.05.20.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 20:31:12 -0800 (PST)
Date:   Wed, 6 Dec 2023 10:00:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, alessandro.carminati@gmail.com,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v7 5/5] arm64: dts: qcom: sm8250: Add OPP table support
 to UFSHC
Message-ID: <20231206043053.GA2899@thinkpad>
References: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
 <20231012172129.65172-6-manivannan.sadhasivam@linaro.org>
 <CGME20231205205609eucas1p2609b01ca4e3527e8b5281dec1d92653c@eucas1p2.samsung.com>
 <486716ef-d099-4613-b2f7-a9fcc42da90c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <486716ef-d099-4613-b2f7-a9fcc42da90c@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:56:07PM +0100, Marek Szyprowski wrote:
> On 12.10.2023 19:21, Manivannan Sadhasivam wrote:
> > UFS host controller, when scaling gears, should choose appropriate
> > performance state of RPMh power domain controller along with clock
> > frequency. So let's add the OPP table support to specify both clock
> > frequency and RPMh performance states replacing the old "freq-table-hz"
> > property.
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> 
> This patch landed in today's linux-next as commit 725be1d6318e ("arm64: 
> dts: qcom: sm8250: Add OPP table support to UFSHC"). Unfortunately it 
> breaks booting of my RB5 board with the following messages:
> 

Thanks for reporting. The issue is due to a regression in the UFS OPP code and
I've already requested Bjorn [1] to drop these DTS patches until the driver fix
gets merged.

- Mani

[1] https://lore.kernel.org/linux-arm-msm/20231204120137.GE35383@thinkpad/

>   ufshcd-qcom 1d84000.ufshc: Adding to iommu group 5
>   ufshcd-qcom 1d84000.ufshc: freq-table-hz property not specified
>   ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find 
> vdd-hba-supply regulator, assuming enabled
>   ufshcd-qcom 1d84000.ufshc: freq-table-hz property not specified
>   ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find 
> vdd-hba-supply regulator, assuming enabled
>   scsi host0: ufshcd
>   ufshcd-qcom 1d84000.ufshc: UNIPRO clk freq 0 MHz not supported
>   ufshcd-qcom 1d84000.ufshc: cfg core clk ctrl failed
>   clk: Disabling unused clocks
>   ALSA device list:
>     No soundcards found.
>   Waiting 2 sec before mounting root device...
>   ufshcd-qcom 1d84000.ufshc: uic cmd 0x16 with arg3 0x0 completion timeout
>   ufshcd-qcom 1d84000.ufshc: Controller enable failed
>   ufshcd-qcom 1d84000.ufshc: Controller enable failed
>   ufshcd-qcom 1d84000.ufshc: Controller enable failed
>   ufshcd-qcom 1d84000.ufshc: Controller enable failed
>   ufshcd-qcom 1d84000.ufshc: link startup failed -110
>   ufshcd-qcom 1d84000.ufshc: UFS Host state=0
>   ufshcd-qcom 1d84000.ufshc: outstanding reqs=0x0 tasks=0x0
>   ufshcd-qcom 1d84000.ufshc: saved_err=0x0, saved_uic_err=0x0
>   ufshcd-qcom 1d84000.ufshc: Device power mode=1, UIC link state=0
>   ufshcd-qcom 1d84000.ufshc: PM in progress=0, sys. suspended=0
>   ufshcd-qcom 1d84000.ufshc: Auto BKOPS=0, Host self-block=0
>   ufshcd-qcom 1d84000.ufshc: Clk gate=1
>   ufshcd-qcom 1d84000.ufshc: last_hibern8_exit_tstamp at 0 us, 
> hibern8_exit_cnt=0
>   ufshcd-qcom 1d84000.ufshc: last intr at 2889168 us, last intr status=0x400
>   ufshcd-qcom 1d84000.ufshc: error handling flags=0x0, req. abort count=0
>   ufshcd-qcom 1d84000.ufshc: hba->ufs_version=0x300, Host 
> capabilities=0x1587031f, caps=0x12cf
>   ufshcd-qcom 1d84000.ufshc: quirks=0x80000, dev. quirks=0x0
>   host_regs: 00000000: 1587031f 00000000 00000300 00000000
>   host_regs: 00000010: 01000000 00010217 00000000 00000000
>   host_regs: 00000020: 00000000 00000000 00000000 00000000
>   host_regs: 00000030: 00000008 00000000 00000000 00000000
>   host_regs: 00000040: 00000000 00000000 00000000 00000000
>   host_regs: 00000050: 00000000 00000000 00000000 00000000
>   host_regs: 00000060: 00000000 00000000 00000000 00000000
>   host_regs: 00000070: 00000000 00000000 00000000 00000000
>   host_regs: 00000080: 00000000 00000000 00000000 00000000
>   host_regs: 00000090: 00000000 00000001 00000000 00000000
>   ufshcd-qcom 1d84000.ufshc: No record of pa_err
>   ufshcd-qcom 1d84000.ufshc: No record of dl_err
>   ufshcd-qcom 1d84000.ufshc: No record of nl_err
>   ufshcd-qcom 1d84000.ufshc: No record of tl_err
>   ufshcd-qcom 1d84000.ufshc: No record of dme_err
>   ufshcd-qcom 1d84000.ufshc: No record of auto_hibern8_err
>   ufshcd-qcom 1d84000.ufshc: No record of fatal_err
>   ufshcd-qcom 1d84000.ufshc: link_startup_fail[0] = 0xffffff92 at 3663462 us
>   ufshcd-qcom 1d84000.ufshc: link_startup_fail: total cnt=1
>   ufshcd-qcom 1d84000.ufshc: No record of resume_fail
>   ufshcd-qcom 1d84000.ufshc: No record of suspend_fail
>   ufshcd-qcom 1d84000.ufshc: No record of wlun resume_fail
>   ufshcd-qcom 1d84000.ufshc: No record of wlun suspend_fail
>   ufshcd-qcom 1d84000.ufshc: No record of dev_reset
>   ufshcd-qcom 1d84000.ufshc: No record of host_reset
>   ufshcd-qcom 1d84000.ufshc: No record of task_abort
>   HCI Vendor Specific Registers 00000000: 0000012c 00000000 00000000 
> 00000000
>   HCI Vendor Specific Registers 00000010: 00000042 00000000 00000001 
> 1c00052c
>   HCI Vendor Specific Registers 00000020: 3f011300 40020000 00000000 
> 00000000
>   HCI Vendor Specific Registers 00000030: 00000000 00000000 00000000 
> 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 00000000: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 00000010: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 00000020: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 00000030: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 00000040: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 00000050: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 00000060: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 00000070: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 00000080: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 00000090: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_REG_OCSC 000000a0: 00000000 00000000 00000000 00000000
>   UFS_UFS_DBG_RD_EDTL_RAM 00000000: 00000000 7147f7fd 47857989 b7556f16
>   UFS_UFS_DBG_RD_EDTL_RAM 00000010: ad69b114 7cd5fd55 41d57796 0e55e717
>   UFS_UFS_DBG_RD_EDTL_RAM 00000020: 04558745 efc573b5 4f35f49b b2697d16
>   UFS_UFS_DBG_RD_EDTL_RAM 00000030: 5c7563d5 7755f4d6 cf65dd90 6591d535
>   UFS_UFS_DBG_RD_EDTL_RAM 00000040: 4151f597 ffaf75a9 57442485 f7654511
>   UFS_UFS_DBG_RD_EDTL_RAM 00000050: fc57e046 ff57f5b5 c7c53417 adb56f55
>   UFS_UFS_DBG_RD_EDTL_RAM 00000060: 9b753f4c 5155a115 245525f1 77755d51
>   UFS_UFS_DBG_RD_EDTL_RAM 00000070: 5791ffdf 77555756 7cd5b941 431ce192
>   UFS_UFS_DBG_RD_DESC_RAM 00000000: 7dfffedf 001fbffb ff7fffff 003ffffd
>   UFS_UFS_DBG_RD_DESC_RAM 00000010: 7f3dfff5 003fffff 7ffdfff3 0017fff7
>   UFS_UFS_DBG_RD_DESC_RAM 00000020: 3fdd595f 003ff5b7 ffffdfdf 003f77f7
>   UFS_UFS_DBG_RD_DESC_RAM 00000030: fffff7d7 003f75f7 7fffffff 0037ffff
>   UFS_UFS_DBG_RD_DESC_RAM 00000040: fdff7f7f 003f57df fdfeffbf 003ffff7
>   UFS_UFS_DBG_RD_DESC_RAM 00000050: 7d7d7fff 00379d7f 7ffd7fff 001f3fff
>   UFS_UFS_DBG_RD_DESC_RAM 00000060: 7f7fdeff 003fffd5 f7f7fffd 003fffff
>   UFS_UFS_DBG_RD_DESC_RAM 00000070: 777ffd7d 003ffd75 ff7ffffd 003f7ffd
>   UFS_UFS_DBG_RD_DESC_RAM 00000080: ff15fddf 003edfd7 df5ffff7 003fffdf
>   UFS_UFS_DBG_RD_DESC_RAM 00000090: ffe57f5f 003fbff7 ddd7ff75 003f7fff
>   UFS_UFS_DBG_RD_DESC_RAM 000000a0: fd4ffffd 003dddff eefffff7 003fbfff
>   UFS_UFS_DBG_RD_DESC_RAM 000000b0: 67fffffd 001ff7fd bdd75f7f 0031bfff
>   UFS_UFS_DBG_RD_DESC_RAM 000000c0: ffdddf75 003fff5d 7f5fffdd 002f7fdf
>   UFS_UFS_DBG_RD_DESC_RAM 000000d0: ff7d5ffd 0037fdff df675fd5 001ffbdf
>   UFS_UFS_DBG_RD_DESC_RAM 000000e0: b5ff7dff 00337ffc ff7ff7fb 003ffff7
>   UFS_UFS_DBG_RD_DESC_RAM 000000f0: 5ffdffdd 001ddfff 75ffddff 003fffff
>   UFS_UFS_DBG_RD_DESC_RAM 00000100: ff5f5fdf 003d37bf ff77dfff 0017edb7
>   UFS_UFS_DBG_RD_DESC_RAM 00000110: ff7ff7ff 003ffd7f ff5f7fdd 003f3fd7
>   UFS_UFS_DBG_RD_DESC_RAM 00000120: 7fffffdf 003ff5d9 55ffffdf 003f79d5
>   UFS_UFS_DBG_RD_DESC_RAM 00000130: d5ffe7f5 002767fe ffdd75df 003d7fdf
>   UFS_UFS_DBG_RD_DESC_RAM 00000140: 7fff77ff 003dff5f 7d7ff7ff 002f7fff
>   UFS_UFS_DBG_RD_DESC_RAM 00000150: fdff7ddf 003fe7dd 5df77ddd 0037f7ff
>   UFS_UFS_DBG_RD_DESC_RAM 00000160: f7f16977 003f9fdf 5775ff77 00357ff5
>   UFS_UFS_DBG_RD_DESC_RAM 00000170: 7ffdfffb 003dff5f 7f7f77f7 003fffff
>   UFS_UFS_DBG_RD_DESC_RAM 00000180: 57dff7df 003dffff fffdd7ff 001efffd
>   UFS_UFS_DBG_RD_DESC_RAM 00000190: 7dffffed 003f7fce 77d9f7ff 001fdddd
>   UFS_UFS_DBG_RD_DESC_RAM 000001a0: ddffdffd 001fd57d 7f7ff777 003f78dd
>   UFS_UFS_DBG_RD_DESC_RAM 000001b0: d5eff77f 0037dfdf ed7d77ff 003ffffd
>   UFS_UFS_DBG_RD_DESC_RAM 000001c0: cf7fdfff 001f5f7e ffffffff 003f57df
>   UFS_UFS_DBG_RD_DESC_RAM 000001d0: fdfffffd 003f7dff 556ffddf 003fdd7f
>   UFS_UFS_DBG_RD_DESC_RAM 000001e0: fdff71df 003e7fff ff3f7fd7 0037f77b
>   UFS_UFS_DBG_RD_DESC_RAM 000001f0: 7f7f7677 00355fdf 7feffdff 0037ffff
>   UFS_UFS_DBG_RD_PRDT_RAM 00000000: d1700001 0000192c 3d9edf71 00075d51
>   UFS_UFS_DBG_RD_PRDT_RAM 00000010: 4561073f 0000415d ddde6dd9 000ff55f
>   UFS_UFS_DBG_RD_PRDT_RAM 00000020: adb7185f 000df971 579caffd 000de54d
>   UFS_UFS_DBG_RD_PRDT_RAM 00000030: 45e55747 00057559 7f5e5dbd 000377df
>   UFS_UFS_DBG_RD_PRDT_RAM 00000040: dd175467 0007dc9c 4e775d77 0007555f
>   UFS_UFS_DBG_RD_PRDT_RAM 00000050: 1f15dd77 000d195d f1c9e535 0007b75f
>   UFS_UFS_DBG_RD_PRDT_RAM 00000060: 15bd75f3 0007675f dfd59d77 00057b5c
>   UFS_UFS_DBG_RD_PRDT_RAM 00000070: d4f09dee 00017d39 52857d56 000c6ddd
>   UFS_UFS_DBG_RD_PRDT_RAM 00000080: c333fcd6 000545df 1d57f51d 000577e9
>   UFS_UFS_DBG_RD_PRDT_RAM 00000090: 9f83d45d 00055d18 d4e7d7ee 000713df
>   UFS_UFS_DBG_RD_PRDT_RAM 000000a0: fdfe39d7 000754df d54f5d77 000746f1
>   UFS_UFS_DBG_RD_PRDT_RAM 000000b0: 5a40c5f5 000c45d4 17471fe3 000e9d1d
>   UFS_UFS_DBG_RD_PRDT_RAM 000000c0: 1747dd5f 00074577 d540d75d 00044d67
>   UFS_UFS_DBG_RD_PRDT_RAM 000000d0: de3545d3 000c4757 5f845115 00063795
>   UFS_UFS_DBG_RD_PRDT_RAM 000000e0: d15d776c 000c7fd5 1f5f5d75 00067d75
>   UFS_UFS_DBG_RD_PRDT_RAM 000000f0: d71d4c7d 0007bd13 7557d77d 000355df
>   UFS_DBG_RD_REG_UAWM 00000000: 00000000 0fe00000 00000004 f4000102
>   UFS_DBG_RD_REG_UARM 00000000: 00000000 00000000 00000001 00000001
>   UFS_DBG_RD_REG_TXUC 00000000: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 00000010: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 00000020: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 00000030: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 00000040: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 00000050: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 00000060: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 00000070: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 00000080: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 00000090: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 000000a0: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TXUC 000000b0: 00000001 00000000 00000000 00000004
>   UFS_DBG_RD_REG_RXUC 00000000: 00000000 00000000 00000000 00000004
>   UFS_DBG_RD_REG_RXUC 00000010: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_RXUC 00000020: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_RXUC 00000030: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_RXUC 00000040: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_RXUC 00000050: 00000000 00000000 00000000 00000001
>   UFS_DBG_RD_REG_RXUC 00000060: 00000000 00000000 00000004
>   UFS_DBG_RD_REG_DFC 00000000: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_DFC 00000010: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_DFC 00000020: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_DFC 00000030: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_DFC 00000040: ffffffff 00000000 00000000
>   UFS_DBG_RD_REG_TRLUT 00000000: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TRLUT 00000010: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TRLUT 00000020: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TRLUT 00000030: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TRLUT 00000040: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TRLUT 00000050: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TRLUT 00000060: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TRLUT 00000070: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TRLUT 00000080: 00000000 00000000
>   UFS_DBG_RD_REG_TMRLUT 00000000: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TMRLUT 00000010: 00000000 00000000 00000000 00000000
>   UFS_DBG_RD_REG_TMRLUT 00000020: 00000000
>   ------------[ cut here ]------------
>   gcc_ufs_phy_axi_clk status stuck at 'off'
>   WARNING: CPU: 3 PID: 103 at drivers/clk/qcom/clk-branch.c:86 
> clk_branch_wait+0x144/0x15c
>   Modules linked in:
>   CPU: 3 PID: 103 Comm: kworker/u17:0 Not tainted 
> 6.7.0-rc4-next-20231205 #14278
>   Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>   Workqueue: ufs_clk_gating_0 ufshcd_ungate_work
>   pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : clk_branch_wait+0x144/0x15c
>   lr : clk_branch_wait+0x144/0x15c
>   sp : ffff80008160bc20
>   x29: ffff80008160bc20 x28: ffffa967de7ea200 x27: 0000000000000000
>   x26: ffff03ffc7bb18e8 x25: 0000000112be0f33 x24: 0000000000000001
>   x23: ffffa967dd981888 x22: 0000000000000001 x21: ffffa967dc27166c
>   x20: 0000000000000000 x19: ffffa967deae9920 x18: 0000000000000038
>   x17: 0000000000000000 x16: 0000000000003ff1 x15: fffffffffffe9c68
>   x14: ffffa967de815360 x13: 0000000000000669 x12: 0000000000000223
>   x11: fffffffffffe9c68 x10: fffffffffffe9c30 x9 : 00000000fffff223
>   x8 : ffffa967de815360 x7 : ffffa967de86d360 x6 : 00000000000019a4
>   x5 : 000000000000bff4 x4 : 00000000fffff223 x3 : 0000000000000000
>   x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff03ffc7266500
>   Call trace:
>    clk_branch_wait+0x144/0x15c
>    clk_branch2_enable+0x30/0x40
>    clk_core_enable+0xe8/0x284
>    clk_enable+0x2c/0x4c
>    ufshcd_setup_clocks+0x268/0x3d4
>    ufshcd_ungate_work+0xc0/0x134
>    process_one_work+0x1ec/0x53c
>    worker_thread+0x298/0x408
>    kthread+0x124/0x128
>    ret_from_fork+0x10/0x20
>   irq event stamp: 76
>   hardirqs last  enabled at (75): [<ffffa967dcc9ced0>] 
> _raw_spin_unlock_irq+0x30/0x6c
>   hardirqs last disabled at (76): [<ffffa967dc224250>] 
> clk_enable_lock+0x7c/0xf0
>   softirqs last  enabled at (0): [<ffffa967dbb186c8>] 
> copy_process+0x650/0x21d8
>   softirqs last disabled at (0): [<0000000000000000>] 0x0
>   ---[ end trace 0000000000000000 ]---
>   ufshcd-qcom 1d84000.ufshc: ufshcd_setup_clocks: core_clk prepare 
> enable failed, -16
> 
> 
> Let me know if you need more logs or information.
> 
> 
> >   arch/arm64/boot/dts/qcom/sm8250.dtsi | 39 +++++++++++++++++++++-------
> >   1 file changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > index a4e58ad731c3..33abd84aae53 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > @@ -2198,21 +2198,42 @@ ufs_mem_hc: ufshc@1d84000 {
> >   				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> >   				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> >   				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> > -			freq-table-hz =
> > -				<37500000 300000000>,
> > -				<0 0>,
> > -				<0 0>,
> > -				<37500000 300000000>,
> > -				<0 0>,
> > -				<0 0>,
> > -				<0 0>,
> > -				<0 0>;
> > +
> > +			operating-points-v2 = <&ufs_opp_table>;
> >   
> >   			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI_CH0 0>,
> >   					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
> >   			interconnect-names = "ufs-ddr", "cpu-ufs";
> >   
> >   			status = "disabled";
> > +
> > +			ufs_opp_table: opp-table {
> > +				compatible = "operating-points-v2";
> > +
> > +				opp-37500000 {
> > +					opp-hz = /bits/ 64 <37500000>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <37500000>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>;
> > +					required-opps = <&rpmhpd_opp_low_svs>;
> > +				};
> > +
> > +				opp-300000000 {
> > +					opp-hz = /bits/ 64 <300000000>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <300000000>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>,
> > +						 /bits/ 64 <0>;
> > +					required-opps = <&rpmhpd_opp_nom>;
> > +				};
> > +			};
> >   		};
> >   
> >   		ufs_mem_phy: phy@1d87000 {
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

-- 
மணிவண்ணன் சதாசிவம்
