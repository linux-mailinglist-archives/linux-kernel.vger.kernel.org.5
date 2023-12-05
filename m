Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFFA805FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346320AbjLEU4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEU4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:56:14 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67399181;
        Tue,  5 Dec 2023 12:56:16 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231205205610euoutp0153399d4a2baee19e6bd99e01dd191539~eCvhJ-YQS0341403414euoutp01A;
        Tue,  5 Dec 2023 20:56:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231205205610euoutp0153399d4a2baee19e6bd99e01dd191539~eCvhJ-YQS0341403414euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701809770;
        bh=BuDjLnU/cH/x2BjAcz3x+I/+EOSlboURBIXJhhEs0QE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=mqQpi8AHKIim6E5uq79v3jbTEJnVLrDdah216z833jZXMU5Rz/Pz6/b0XTCMIw5SW
         CK2ujAG5zT7LWf7lWSZjyERwpPL/K3aEfKREYi/2vLUTeIWqC03Vsg30SZkl7CRwg+
         H9Wz+BdvifTVxrjPkdsQW5nVn36tRK4GzJZEb/b8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231205205609eucas1p2ae2fa1ece9fa7f669c26c54293ef50dd~eCvgIzpKp0579505795eucas1p27;
        Tue,  5 Dec 2023 20:56:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C7.E1.09539.96E8F656; Tue,  5
        Dec 2023 20:56:09 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231205205609eucas1p2609b01ca4e3527e8b5281dec1d92653c~eCvflOlC_2856728567eucas1p2I;
        Tue,  5 Dec 2023 20:56:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231205205608eusmtrp22b31d4a68fb1f1d3f300caa394708715~eCvfkZDTx1865418654eusmtrp2a;
        Tue,  5 Dec 2023 20:56:08 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-a7-656f8e69514a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.EC.09274.86E8F656; Tue,  5
        Dec 2023 20:56:08 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231205205607eusmtip15d854efda797c58a8e7a0176b3b5a554~eCveEd26j0329903299eusmtip1c;
        Tue,  5 Dec 2023 20:56:07 +0000 (GMT)
Message-ID: <486716ef-d099-4613-b2f7-a9fcc42da90c@samsung.com>
Date:   Tue, 5 Dec 2023 21:56:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] arm64: dts: qcom: sm8250: Add OPP table support
 to UFSHC
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, alessandro.carminati@gmail.com,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20231012172129.65172-6-manivannan.sadhasivam@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG/c45nB66lRwryjfcZLZDJptcdv1UQmAxeJIti8mckUWjzThB
        BhRtYY45FCcrpbqudJtoQW5Z5OI2J5e2MBBGGopCYQIiFrDci4KUihtUNjbKwY3/fu/zPm+e
        9/3yUbiwmfSl4qTJrEwqSRCRfELf7OrYFqdOYkMcrc+hwu5qHA3m60mkV4ah+67bJGqxtBHo
        /IwLRz/Wt2PozmO7ByowtXug7A4XiYp79RhSfmsgkHpiCEf1k9U8ZPlyioeyGyw81FWbR6LZ
        r00Anb1jJNFARpYHKjEvYqjvdCmJpuYtGCpSXiKQacSBI23PLyRSVZbi6PsJMw8ZbZkAzWkM
        PLQwpyXRV/UmHlrsuUagysFmMkLEdHW/y9ToBnhMRXkWyfT31JGMprgRMM4xK8Fk151kHNdv
        k4y6qhww5l4DxsxWbGIyG89ie579iB8WwybEfcrKgsMP84+MTuaSRxVpn+VN9RPpID1eBTwp
        SL8Bu2/8RaoAnxLSpQDODE9jXPEYwK5KA8EVswCOl2nJpyPT3YUebhbSJQAWV66YnAAqDbZl
        k4AOh/llRcDNBP0SdDZ8h3H6Wnjj4ijh5vW0H7RZL/DcvI7eB+eqSpZ1nPaB1tGC5TW8aQcG
        BzWLONeoI6C6Zb+bSToUqh6qlsM86ShYZ5njcR4/eKY6F3cPQ/ouH06bG3nc2rtgR6l6hdfB
        B+aqFX4e/lPDpUE6E8DCBdtKoQEw3W4FnGsn7G9/shRHLUVshVdrgzk5Ejpdlwm3DGkv2Ptw
        LbeEF9Tqc3BOFkClQsi5t0Cd+ef/Yn/7vRPXAJFu1bvoVt2vW3WO7v/cQkCUAx82RZ4Yy8pD
        pezxILkkUZ4ijQ36OCmxAix99dZF8yMjuPTAGdQEMAo0AUjhIm9BvjWeFQpiJKmfs7KkQ7KU
        BFbeBDZShMhH4B/jxwrpWEkyG8+yR1nZ0y5GefqmY96P5m5tjx85Pdm3z3dDVMG0v+PtDdLx
        tzJGxEM/HTL2zfz6Suq9cqLt/hr7J/LLIXbHB22UMeCc/ZmhiAOBshcyB4aHAjfHsGnfbGmR
        B98tPrbmXu8O//moD/Xhr2491/piQJElslN7s9kaib1uHvPZYVVFA37k+3knTJuU4y87ihS2
        zjSv/fV/52dINSDyxK1BdZbpSmdDwMHjiX/WJl9ZP3RqJio85ZqmOyL61DFx8oHWsDD/H64q
        WSq6ducf5JuvDXgcztGefCfVFDKB9m4brclRNO3OEu9RCcaG7dM9CeIz7z2xbdycdP0LRUlZ
        U4NItz1ql3h+YW+1wi/pYG7OBeHumyJCfkQSGojL5JJ/AVGcxYxZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsVy+t/xu7oZffmpBrtmmlosuLKV2eLBvG1s
        Fts6bCxe/rzKZnHi7BkWi2kffjJbrNl7jsni+pfnrBbzj5xjtZh4/iebxaIb25gsOiZvZ7Ho
        e/GQ2WLv663sFmeb3rBbTNx/lt3i8q45bBafe48wWnRf38Fmcbelk9Vi+fF/TBa3G1ewWbz5
        cZbJYmHHXBaLI4/fM1tMuraBzaJr8wpmi6kvjrNb7LjfzmjxfcJ2dovf3yexWbTuPcJu8e/a
        RhaLzQ+OsTkoeVy+4u2xc9Zddo9NqzrZPO5c28PmMWHRAUaPj09vsXhM3FPn8X7fVTaPvi2r
        GD2O39jO5PF5k5xH+4FupgCeKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MJ69nsxW01VbMeXOHpYGxIbuLkZNDQsBE4t2VBaxdjFwcQgJLGSU2
        rt7NCpGQkTg5rQHKFpb4c62LDaLoPaPEgkuzmEESvAJ2EvNWLmQEsVkEVCQ+7p/CBBEXlDg5
        8wkLiC0qIC9x/9YMdhBbWCBMYsnG12A1zALiEreezAezRQTeM0nsvZcBsoBZYA+LxPeve5gg
        tjUySix6exJsEpuAoUTXW5AzODk4Bdwk9pz9zg4xyUyia2sXI4QtL9G8dTbzBEahWUgOmYVk
        4SwkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRmMa2Hfu5ZQfjylcf9Q4xMnEw
        HmKU4GBWEuGddys7VYg3JbGyKrUoP76oNCe1+BCjKTA0JjJLiSbnAxNpXkm8oZmBqaGJmaWB
        qaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDk1/UY5Ozfb5T/Xqv9F6u/yu+d8+t+1oK
        BeazeMxXh3AcVcyaOufk1k0WTw9PUDI87JSzYKrca5/Ilf8CL7D4Nn9weij+tXzXxN2NhwJl
        ug3n6evz/TO+z/1E9ofI1kvhyj8XxX2a73s7f2fWX/1ts1h/CFz9tsTwfF/gbo9/W+dUzPR+
        xhbK9lHEKax3tu5jliqDXvW1IuKfNz8LKO/5dyw9pWa7+32Zs+fE3oq9Tzl464veyfpvvD9e
        Mkt9Vb4ya73h5IPCQZa/ZHWWGW6pmG7vPj/m/XeLv1xX1I4sfulTuld73/ktErF1ASpC25ju
        vdVnvVisOTXZYJITV/WsjhVx0/gFr/b2bF7zUn/fKWslluKMREMt5qLiRABO+BDg7AMAAA==
X-CMS-MailID: 20231205205609eucas1p2609b01ca4e3527e8b5281dec1d92653c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231205205609eucas1p2609b01ca4e3527e8b5281dec1d92653c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231205205609eucas1p2609b01ca4e3527e8b5281dec1d92653c
References: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
        <20231012172129.65172-6-manivannan.sadhasivam@linaro.org>
        <CGME20231205205609eucas1p2609b01ca4e3527e8b5281dec1d92653c@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.2023 19:21, Manivannan Sadhasivam wrote:
> UFS host controller, when scaling gears, should choose appropriate
> performance state of RPMh power domain controller along with clock
> frequency. So let's add the OPP table support to specify both clock
> frequency and RPMh performance states replacing the old "freq-table-hz"
> property.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---


This patch landed in today's linux-next as commit 725be1d6318e ("arm64: 
dts: qcom: sm8250: Add OPP table support to UFSHC"). Unfortunately it 
breaks booting of my RB5 board with the following messages:

  ufshcd-qcom 1d84000.ufshc: Adding to iommu group 5
  ufshcd-qcom 1d84000.ufshc: freq-table-hz property not specified
  ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find 
vdd-hba-supply regulator, assuming enabled
  ufshcd-qcom 1d84000.ufshc: freq-table-hz property not specified
  ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find 
vdd-hba-supply regulator, assuming enabled
  scsi host0: ufshcd
  ufshcd-qcom 1d84000.ufshc: UNIPRO clk freq 0 MHz not supported
  ufshcd-qcom 1d84000.ufshc: cfg core clk ctrl failed
  clk: Disabling unused clocks
  ALSA device list:
    No soundcards found.
  Waiting 2 sec before mounting root device...
  ufshcd-qcom 1d84000.ufshc: uic cmd 0x16 with arg3 0x0 completion timeout
  ufshcd-qcom 1d84000.ufshc: Controller enable failed
  ufshcd-qcom 1d84000.ufshc: Controller enable failed
  ufshcd-qcom 1d84000.ufshc: Controller enable failed
  ufshcd-qcom 1d84000.ufshc: Controller enable failed
  ufshcd-qcom 1d84000.ufshc: link startup failed -110
  ufshcd-qcom 1d84000.ufshc: UFS Host state=0
  ufshcd-qcom 1d84000.ufshc: outstanding reqs=0x0 tasks=0x0
  ufshcd-qcom 1d84000.ufshc: saved_err=0x0, saved_uic_err=0x0
  ufshcd-qcom 1d84000.ufshc: Device power mode=1, UIC link state=0
  ufshcd-qcom 1d84000.ufshc: PM in progress=0, sys. suspended=0
  ufshcd-qcom 1d84000.ufshc: Auto BKOPS=0, Host self-block=0
  ufshcd-qcom 1d84000.ufshc: Clk gate=1
  ufshcd-qcom 1d84000.ufshc: last_hibern8_exit_tstamp at 0 us, 
hibern8_exit_cnt=0
  ufshcd-qcom 1d84000.ufshc: last intr at 2889168 us, last intr status=0x400
  ufshcd-qcom 1d84000.ufshc: error handling flags=0x0, req. abort count=0
  ufshcd-qcom 1d84000.ufshc: hba->ufs_version=0x300, Host 
capabilities=0x1587031f, caps=0x12cf
  ufshcd-qcom 1d84000.ufshc: quirks=0x80000, dev. quirks=0x0
  host_regs: 00000000: 1587031f 00000000 00000300 00000000
  host_regs: 00000010: 01000000 00010217 00000000 00000000
  host_regs: 00000020: 00000000 00000000 00000000 00000000
  host_regs: 00000030: 00000008 00000000 00000000 00000000
  host_regs: 00000040: 00000000 00000000 00000000 00000000
  host_regs: 00000050: 00000000 00000000 00000000 00000000
  host_regs: 00000060: 00000000 00000000 00000000 00000000
  host_regs: 00000070: 00000000 00000000 00000000 00000000
  host_regs: 00000080: 00000000 00000000 00000000 00000000
  host_regs: 00000090: 00000000 00000001 00000000 00000000
  ufshcd-qcom 1d84000.ufshc: No record of pa_err
  ufshcd-qcom 1d84000.ufshc: No record of dl_err
  ufshcd-qcom 1d84000.ufshc: No record of nl_err
  ufshcd-qcom 1d84000.ufshc: No record of tl_err
  ufshcd-qcom 1d84000.ufshc: No record of dme_err
  ufshcd-qcom 1d84000.ufshc: No record of auto_hibern8_err
  ufshcd-qcom 1d84000.ufshc: No record of fatal_err
  ufshcd-qcom 1d84000.ufshc: link_startup_fail[0] = 0xffffff92 at 3663462 us
  ufshcd-qcom 1d84000.ufshc: link_startup_fail: total cnt=1
  ufshcd-qcom 1d84000.ufshc: No record of resume_fail
  ufshcd-qcom 1d84000.ufshc: No record of suspend_fail
  ufshcd-qcom 1d84000.ufshc: No record of wlun resume_fail
  ufshcd-qcom 1d84000.ufshc: No record of wlun suspend_fail
  ufshcd-qcom 1d84000.ufshc: No record of dev_reset
  ufshcd-qcom 1d84000.ufshc: No record of host_reset
  ufshcd-qcom 1d84000.ufshc: No record of task_abort
  HCI Vendor Specific Registers 00000000: 0000012c 00000000 00000000 
00000000
  HCI Vendor Specific Registers 00000010: 00000042 00000000 00000001 
1c00052c
  HCI Vendor Specific Registers 00000020: 3f011300 40020000 00000000 
00000000
  HCI Vendor Specific Registers 00000030: 00000000 00000000 00000000 
00000000
  UFS_UFS_DBG_RD_REG_OCSC 00000000: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_REG_OCSC 00000010: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_REG_OCSC 00000020: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_REG_OCSC 00000030: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_REG_OCSC 00000040: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_REG_OCSC 00000050: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_REG_OCSC 00000060: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_REG_OCSC 00000070: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_REG_OCSC 00000080: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_REG_OCSC 00000090: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_REG_OCSC 000000a0: 00000000 00000000 00000000 00000000
  UFS_UFS_DBG_RD_EDTL_RAM 00000000: 00000000 7147f7fd 47857989 b7556f16
  UFS_UFS_DBG_RD_EDTL_RAM 00000010: ad69b114 7cd5fd55 41d57796 0e55e717
  UFS_UFS_DBG_RD_EDTL_RAM 00000020: 04558745 efc573b5 4f35f49b b2697d16
  UFS_UFS_DBG_RD_EDTL_RAM 00000030: 5c7563d5 7755f4d6 cf65dd90 6591d535
  UFS_UFS_DBG_RD_EDTL_RAM 00000040: 4151f597 ffaf75a9 57442485 f7654511
  UFS_UFS_DBG_RD_EDTL_RAM 00000050: fc57e046 ff57f5b5 c7c53417 adb56f55
  UFS_UFS_DBG_RD_EDTL_RAM 00000060: 9b753f4c 5155a115 245525f1 77755d51
  UFS_UFS_DBG_RD_EDTL_RAM 00000070: 5791ffdf 77555756 7cd5b941 431ce192
  UFS_UFS_DBG_RD_DESC_RAM 00000000: 7dfffedf 001fbffb ff7fffff 003ffffd
  UFS_UFS_DBG_RD_DESC_RAM 00000010: 7f3dfff5 003fffff 7ffdfff3 0017fff7
  UFS_UFS_DBG_RD_DESC_RAM 00000020: 3fdd595f 003ff5b7 ffffdfdf 003f77f7
  UFS_UFS_DBG_RD_DESC_RAM 00000030: fffff7d7 003f75f7 7fffffff 0037ffff
  UFS_UFS_DBG_RD_DESC_RAM 00000040: fdff7f7f 003f57df fdfeffbf 003ffff7
  UFS_UFS_DBG_RD_DESC_RAM 00000050: 7d7d7fff 00379d7f 7ffd7fff 001f3fff
  UFS_UFS_DBG_RD_DESC_RAM 00000060: 7f7fdeff 003fffd5 f7f7fffd 003fffff
  UFS_UFS_DBG_RD_DESC_RAM 00000070: 777ffd7d 003ffd75 ff7ffffd 003f7ffd
  UFS_UFS_DBG_RD_DESC_RAM 00000080: ff15fddf 003edfd7 df5ffff7 003fffdf
  UFS_UFS_DBG_RD_DESC_RAM 00000090: ffe57f5f 003fbff7 ddd7ff75 003f7fff
  UFS_UFS_DBG_RD_DESC_RAM 000000a0: fd4ffffd 003dddff eefffff7 003fbfff
  UFS_UFS_DBG_RD_DESC_RAM 000000b0: 67fffffd 001ff7fd bdd75f7f 0031bfff
  UFS_UFS_DBG_RD_DESC_RAM 000000c0: ffdddf75 003fff5d 7f5fffdd 002f7fdf
  UFS_UFS_DBG_RD_DESC_RAM 000000d0: ff7d5ffd 0037fdff df675fd5 001ffbdf
  UFS_UFS_DBG_RD_DESC_RAM 000000e0: b5ff7dff 00337ffc ff7ff7fb 003ffff7
  UFS_UFS_DBG_RD_DESC_RAM 000000f0: 5ffdffdd 001ddfff 75ffddff 003fffff
  UFS_UFS_DBG_RD_DESC_RAM 00000100: ff5f5fdf 003d37bf ff77dfff 0017edb7
  UFS_UFS_DBG_RD_DESC_RAM 00000110: ff7ff7ff 003ffd7f ff5f7fdd 003f3fd7
  UFS_UFS_DBG_RD_DESC_RAM 00000120: 7fffffdf 003ff5d9 55ffffdf 003f79d5
  UFS_UFS_DBG_RD_DESC_RAM 00000130: d5ffe7f5 002767fe ffdd75df 003d7fdf
  UFS_UFS_DBG_RD_DESC_RAM 00000140: 7fff77ff 003dff5f 7d7ff7ff 002f7fff
  UFS_UFS_DBG_RD_DESC_RAM 00000150: fdff7ddf 003fe7dd 5df77ddd 0037f7ff
  UFS_UFS_DBG_RD_DESC_RAM 00000160: f7f16977 003f9fdf 5775ff77 00357ff5
  UFS_UFS_DBG_RD_DESC_RAM 00000170: 7ffdfffb 003dff5f 7f7f77f7 003fffff
  UFS_UFS_DBG_RD_DESC_RAM 00000180: 57dff7df 003dffff fffdd7ff 001efffd
  UFS_UFS_DBG_RD_DESC_RAM 00000190: 7dffffed 003f7fce 77d9f7ff 001fdddd
  UFS_UFS_DBG_RD_DESC_RAM 000001a0: ddffdffd 001fd57d 7f7ff777 003f78dd
  UFS_UFS_DBG_RD_DESC_RAM 000001b0: d5eff77f 0037dfdf ed7d77ff 003ffffd
  UFS_UFS_DBG_RD_DESC_RAM 000001c0: cf7fdfff 001f5f7e ffffffff 003f57df
  UFS_UFS_DBG_RD_DESC_RAM 000001d0: fdfffffd 003f7dff 556ffddf 003fdd7f
  UFS_UFS_DBG_RD_DESC_RAM 000001e0: fdff71df 003e7fff ff3f7fd7 0037f77b
  UFS_UFS_DBG_RD_DESC_RAM 000001f0: 7f7f7677 00355fdf 7feffdff 0037ffff
  UFS_UFS_DBG_RD_PRDT_RAM 00000000: d1700001 0000192c 3d9edf71 00075d51
  UFS_UFS_DBG_RD_PRDT_RAM 00000010: 4561073f 0000415d ddde6dd9 000ff55f
  UFS_UFS_DBG_RD_PRDT_RAM 00000020: adb7185f 000df971 579caffd 000de54d
  UFS_UFS_DBG_RD_PRDT_RAM 00000030: 45e55747 00057559 7f5e5dbd 000377df
  UFS_UFS_DBG_RD_PRDT_RAM 00000040: dd175467 0007dc9c 4e775d77 0007555f
  UFS_UFS_DBG_RD_PRDT_RAM 00000050: 1f15dd77 000d195d f1c9e535 0007b75f
  UFS_UFS_DBG_RD_PRDT_RAM 00000060: 15bd75f3 0007675f dfd59d77 00057b5c
  UFS_UFS_DBG_RD_PRDT_RAM 00000070: d4f09dee 00017d39 52857d56 000c6ddd
  UFS_UFS_DBG_RD_PRDT_RAM 00000080: c333fcd6 000545df 1d57f51d 000577e9
  UFS_UFS_DBG_RD_PRDT_RAM 00000090: 9f83d45d 00055d18 d4e7d7ee 000713df
  UFS_UFS_DBG_RD_PRDT_RAM 000000a0: fdfe39d7 000754df d54f5d77 000746f1
  UFS_UFS_DBG_RD_PRDT_RAM 000000b0: 5a40c5f5 000c45d4 17471fe3 000e9d1d
  UFS_UFS_DBG_RD_PRDT_RAM 000000c0: 1747dd5f 00074577 d540d75d 00044d67
  UFS_UFS_DBG_RD_PRDT_RAM 000000d0: de3545d3 000c4757 5f845115 00063795
  UFS_UFS_DBG_RD_PRDT_RAM 000000e0: d15d776c 000c7fd5 1f5f5d75 00067d75
  UFS_UFS_DBG_RD_PRDT_RAM 000000f0: d71d4c7d 0007bd13 7557d77d 000355df
  UFS_DBG_RD_REG_UAWM 00000000: 00000000 0fe00000 00000004 f4000102
  UFS_DBG_RD_REG_UARM 00000000: 00000000 00000000 00000001 00000001
  UFS_DBG_RD_REG_TXUC 00000000: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 00000010: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 00000020: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 00000030: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 00000040: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 00000050: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 00000060: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 00000070: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 00000080: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 00000090: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 000000a0: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TXUC 000000b0: 00000001 00000000 00000000 00000004
  UFS_DBG_RD_REG_RXUC 00000000: 00000000 00000000 00000000 00000004
  UFS_DBG_RD_REG_RXUC 00000010: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_RXUC 00000020: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_RXUC 00000030: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_RXUC 00000040: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_RXUC 00000050: 00000000 00000000 00000000 00000001
  UFS_DBG_RD_REG_RXUC 00000060: 00000000 00000000 00000004
  UFS_DBG_RD_REG_DFC 00000000: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_DFC 00000010: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_DFC 00000020: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_DFC 00000030: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_DFC 00000040: ffffffff 00000000 00000000
  UFS_DBG_RD_REG_TRLUT 00000000: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TRLUT 00000010: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TRLUT 00000020: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TRLUT 00000030: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TRLUT 00000040: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TRLUT 00000050: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TRLUT 00000060: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TRLUT 00000070: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TRLUT 00000080: 00000000 00000000
  UFS_DBG_RD_REG_TMRLUT 00000000: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TMRLUT 00000010: 00000000 00000000 00000000 00000000
  UFS_DBG_RD_REG_TMRLUT 00000020: 00000000
  ------------[ cut here ]------------
  gcc_ufs_phy_axi_clk status stuck at 'off'
  WARNING: CPU: 3 PID: 103 at drivers/clk/qcom/clk-branch.c:86 
clk_branch_wait+0x144/0x15c
  Modules linked in:
  CPU: 3 PID: 103 Comm: kworker/u17:0 Not tainted 
6.7.0-rc4-next-20231205 #14278
  Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
  Workqueue: ufs_clk_gating_0 ufshcd_ungate_work
  pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : clk_branch_wait+0x144/0x15c
  lr : clk_branch_wait+0x144/0x15c
  sp : ffff80008160bc20
  x29: ffff80008160bc20 x28: ffffa967de7ea200 x27: 0000000000000000
  x26: ffff03ffc7bb18e8 x25: 0000000112be0f33 x24: 0000000000000001
  x23: ffffa967dd981888 x22: 0000000000000001 x21: ffffa967dc27166c
  x20: 0000000000000000 x19: ffffa967deae9920 x18: 0000000000000038
  x17: 0000000000000000 x16: 0000000000003ff1 x15: fffffffffffe9c68
  x14: ffffa967de815360 x13: 0000000000000669 x12: 0000000000000223
  x11: fffffffffffe9c68 x10: fffffffffffe9c30 x9 : 00000000fffff223
  x8 : ffffa967de815360 x7 : ffffa967de86d360 x6 : 00000000000019a4
  x5 : 000000000000bff4 x4 : 00000000fffff223 x3 : 0000000000000000
  x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff03ffc7266500
  Call trace:
   clk_branch_wait+0x144/0x15c
   clk_branch2_enable+0x30/0x40
   clk_core_enable+0xe8/0x284
   clk_enable+0x2c/0x4c
   ufshcd_setup_clocks+0x268/0x3d4
   ufshcd_ungate_work+0xc0/0x134
   process_one_work+0x1ec/0x53c
   worker_thread+0x298/0x408
   kthread+0x124/0x128
   ret_from_fork+0x10/0x20
  irq event stamp: 76
  hardirqs last  enabled at (75): [<ffffa967dcc9ced0>] 
_raw_spin_unlock_irq+0x30/0x6c
  hardirqs last disabled at (76): [<ffffa967dc224250>] 
clk_enable_lock+0x7c/0xf0
  softirqs last  enabled at (0): [<ffffa967dbb186c8>] 
copy_process+0x650/0x21d8
  softirqs last disabled at (0): [<0000000000000000>] 0x0
  ---[ end trace 0000000000000000 ]---
  ufshcd-qcom 1d84000.ufshc: ufshcd_setup_clocks: core_clk prepare 
enable failed, -16


Let me know if you need more logs or information.


>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 39 +++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index a4e58ad731c3..33abd84aae53 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2198,21 +2198,42 @@ ufs_mem_hc: ufshc@1d84000 {
>   				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>   				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
>   				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> -			freq-table-hz =
> -				<37500000 300000000>,
> -				<0 0>,
> -				<0 0>,
> -				<37500000 300000000>,
> -				<0 0>,
> -				<0 0>,
> -				<0 0>,
> -				<0 0>;
> +
> +			operating-points-v2 = <&ufs_opp_table>;
>   
>   			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI_CH0 0>,
>   					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
>   			interconnect-names = "ufs-ddr", "cpu-ufs";
>   
>   			status = "disabled";
> +
> +			ufs_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-37500000 {
> +					opp-hz = /bits/ 64 <37500000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <37500000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-300000000 {
> +					opp-hz = /bits/ 64 <300000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <300000000>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>,
> +						 /bits/ 64 <0>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +				};
> +			};
>   		};
>   
>   		ufs_mem_phy: phy@1d87000 {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

