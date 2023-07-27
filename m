Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BCF76506D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjG0J4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjG0J4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:56:13 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5223E44
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:55:50 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230727095547epoutp02d508f580e1a822ce2dd0b893b3171e3f~1sOh6ZFnL0982109821epoutp02v
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:55:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230727095547epoutp02d508f580e1a822ce2dd0b893b3171e3f~1sOh6ZFnL0982109821epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690451747;
        bh=w4t+TIXcQTWW1EtJmZ0NUu+9woxMGPOPSa1OtnJ9GIk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=TYXLi5w7B36xUGmIveIMznsuzfkRjqn17ZDzntURZCX1TIy1d6vzc+sqVWLtu0UPV
         YXqEvdWQebOJbEoFjfY04bwdw2IoGznsd4DS20Th1QltyM8W9Su5cp3yA2DpBLdzTa
         5qTu/5Z3gwHn+Lez+pxECOduIjUHnd74ys1wgbs4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230727095546epcas1p29bf5ba55ada2e3dd0a725be5beb23158~1sOgnlGHZ1069310693epcas1p2Q;
        Thu, 27 Jul 2023 09:55:46 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.144]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RBR3P2NKFz4x9Pw; Thu, 27 Jul
        2023 09:55:45 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.B3.57829.12F32C46; Thu, 27 Jul 2023 18:55:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230727095544epcas1p4098af0cd2aa424d8f45fd225923ffdc0~1sOewa4EY0314403144epcas1p4X;
        Thu, 27 Jul 2023 09:55:44 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230727095544epsmtrp1b513f1b63ea08d56165c591ced1298a3~1sOevjWnb0811908119epsmtrp14;
        Thu, 27 Jul 2023 09:55:44 +0000 (GMT)
X-AuditID: b6c32a33-3c7ff7000001e1e5-8f-64c23f211324
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.26.64355.02F32C46; Thu, 27 Jul 2023 18:55:44 +0900 (KST)
Received: from kson001 (unknown [10.102.7.58]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230727095543epsmtip262120e774a524033e29451ca3ab7024c~1sOeanfFD1259912599epsmtip2_;
        Thu, 27 Jul 2023 09:55:43 +0000 (GMT)
From:   "Kwanghoon Son" <k.son@samsung.com>
To:     "'Jisheng Zhang'" <jszhang@kernel.org>,
        "'Drew Fustini'" <dfustini@baylibre.com>
Cc:     "'Conor Dooley'" <conor@kernel.org>,
        "'Guo Ren'" <guoren@kernel.org>, "'Fu Wei'" <wefu@redhat.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        "'Paul Walmsley'" <paul.walmsley@sifive.com>,
        "'Palmer Dabbelt'" <palmer@dabbelt.com>,
        "'Albert Ou'" <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Robert Nelson'" <robertcnelson@beagleboard.org>,
        "'Jason Kridner'" <jkridner@beagleboard.org>
In-Reply-To: <ZL3Eenj4lGZDhZTM@xhacker>
Subject: RE: [PATCH 1/3] riscv: dts: thead: add BeagleV Ahead board device
 tree
Date:   Thu, 27 Jul 2023 18:55:37 +0900
Message-ID: <000001d9c070$82638290$872a87b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIB9/5esCP8yCnQimst/KE+mdvGiAGXz9swAmuuv98C2chcrQD+/XkaAbT+JRavMGV9AA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmga6i/aEUg1tH+C22/p7FbrFm7zkm
        i5VTV7FZzD9yjtWiddIXdosXextZLI5uP8Vu0XxsPZtF34uHzBaXd81hs9j2uYXN4uXlHmaL
        tln8Fh3z5rBYtO49wm7Rsn8Ki4OAx/sbrewe734vY/R48/Ili8fhji/sHptWdbJ53Lm2h81j
        85J6j/f7rrJ5XGq+zu7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
        kkJeYm6qrZKLT4CuW2YO0CtKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALTAr3i
        xNzi0rx0vbzUEitDAwMjU6DChOyMT6cPsxW8561Yvn0JawPjA64uRg4OCQETibWL87oYuTiE
        BHYwSvzs+cwE4XxilHi+/BtLFyMnhHN/nytMw8GnihA1OxklFhyfyQ7hPGaUuLH5GxNIA5uA
        psTCc78ZQWwRgTCJbws/MYPYzAIHWSQ674mC2JwC6hK9DTvBaoQFAiW6v+4FW8YioCrxdN81
        sDivgKXEiv1fWCBsQYmTM5+wQMyRl9j+dg7YTAkBBYmfT5exwuxaOvs0E0SNiMTszjZmkOMk
        BL5wSPxYcAOqwUWiZ2cnO4QtLPHq+BYoW0riZX8blJ0tcfTjXjYIu0Ti+qxFrBC2scT+pZOZ
        QCHBDPTk+l36EGFFiZ2/5zJC7OWTePe1hxUSWLwSHW1CEKa8xK3OcohqUYkzTz+yTWBUmoXk
        sVlIHpuF5IFZCLsWMLKsYhRLLSjOTU9NNiwwhMd0cn7uJkZwEtcy3sF4ef4/vUOMTByMhxgl
        OJiVRHgNY/alCPGmJFZWpRblxxeV5qQWH2I0BQb1RGYp0eR8YB7JK4k3NLE0MDEzMjaxMDQz
        VBLnVZwwO0VIID2xJDU7NbUgtQimj4mDU6qBaaP64cbsQ7r//qklvTK4cfbTlmuuzLtbBNi2
        3ttwlcFthVlfEduu+HlbHq/5+qbwu//kjUfjdposLzaZ6c927du0vFSPH67/PNst1jBIcLce
        CSm1NObIOcBg/VLo7wfW9S5HtZaXBNz5zO4S2mdzVyH4/17Fqqe8miE6X9z8VB/8VQ8vYVbS
        MH4i7v2F7Z9L2/oP+dVqQeeCV8wwuJXDnXnvgRBT7PYDcuHC1941JPybs3jrjWIunueTt311
        vlrT9MT04dqoXczPfP4IabzO7L4U8TPW7OW6y4slXCR9F0ye27mzcOn02MlCszlm7Oh9vbyk
        oyFT8a7goVM3f2ffqopIE7/frPImVD9WO+THBiWW4oxEQy3mouJEALvo2IprBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSvK6C/aEUg4YWLoutv2exW6zZe47J
        YuXUVWwW84+cY7VonfSF3eLF3kYWi6PbT7FbNB9bz2bR9+Ihs8XlXXPYLLZ9bmGzeHm5h9mi
        bRa/Rce8OSwWrXuPsFu07J/C4iDg8f5GK7vHu9/LGD3evHzJ4nG44wu7x6ZVnWwed67tYfPY
        vKTe4/2+q2wel5qvs3t83iQXwBXFZZOSmpNZllqkb5fAlfHp9GG2gve8Fcu3L2FtYHzA1cXI
        wSEhYCJx8KliFyMXh5DAdkaJ9qftbF2MnEBxUYmOy42MEDXCEocPF0PUPGSUaNq6gAmkhk1A
        U2Lhud9gNSICYRK/HpaA1DALnGaR+PWjhxmi4QiTRHf3cmaQBk4BdYnehp2MILawgL/E1G83
        wOIsAqoST/ddA4vzClhKrNj/hQXCFpQ4OfMJC8gCZgE9ibaNYCXMAvIS29/OYYa4U0Hi59Nl
        rCA2yA1LZ59mgqgRkZjd2cY8gVF4FpJJsxAmzUIyaRaSjgWMLKsYRVMLinPTc5MLDPWKE3OL
        S/PS9ZLzczcxgiNZK2gH47L1f/UOMTJxMB5ilOBgVhLhNYzZlyLEm5JYWZValB9fVJqTWnyI
        UZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXAtLhAVSv9TGhirs+WxTbdVeam2qnPF1fp
        Pl3b46rVzlKxcYnthTsdX/a6X7TzWn4nu2+L4qSF3x/mbLnIuWHLzEbTE5HP9N5vz36/vVB9
        4q7midckLjWWiR8LCNvl3M128+Z/eQMOLYGXlZcNQtcs8Jwqcidyr+B0n/grrLMVxfl8/rzR
        32jQevJtlKzaoWPCbzIvRfheN7J5vE3P5W7HtthuiboP+9nvbPt08K378deuO2ZObF3rkPv5
        UGDh83gt0SjV6Oa6SRySts5CMV8jH9hIpBX87OJdfr7WQEOhxMR/+3e/OYKs07aFWlutOhDp
        x8vY8OuhZIlXpuW6wM1pz7X0NgiwhR04mvdSxiVOiaU4I9FQi7moOBEAxd8R3VMDAAA=
X-CMS-MailID: 20230727095544epcas1p4098af0cd2aa424d8f45fd225923ffdc0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230724003542epcas1p4c6c8dbd042af792bc168e10c6e81e45d
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
        <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
        <20230723-savor-trolling-e35ed4a7a751@spud> <ZL1jlacHj7sgNg8M@x1>
        <CGME20230724003542epcas1p4c6c8dbd042af792bc168e10c6e81e45d@epcas1p4.samsung.com>
        <ZL3Eenj4lGZDhZTM@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Jul 23, 2023 at 10:29:57AM -0700, Drew Fustini wrote:
> > On Sun, Jul 23, 2023 at 11:32:17AM +0100, Conor Dooley wrote:
> > > On Sat, Jul 22, 2023 at 02:55:39PM -0700, Drew Fustini wrote:
> > >
> > > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > @@ -0,0 +1,61 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > >
> > > Hmm, should this not be dual licensed?
> > > I notice the other th1520 stuff isn't either..
> >
> > Good point, I'll resubmit with a dual license.
> >
> > Jisheng: are you okay with the other arch/riscv/boot/dts/thead files
> > changing to a dual license?
> 
> When cooking the initial patch, I wrote the lpi4a dts files from
> scratch based on sipeed opened sch file, and currently only I made
> contributions to them, so it's easy to make the lpi4a dts files
> dual license.

Thanks for your work.
Is there any datasheet or user manual can get on public?
I'm going to contribute drivers in my spare time,
but it's hard to know the register file and dma information.

> However, when constructing the th1520.dtsi, I refered the T-HEAD's
> opensourced yocto repo(in fact, that's the only sourcecode/doc I have
> at that time), and the license there is GPL-2.0. That's
> also the reason why copyright of Alibaba Group Holding Limited is
> added to th1520.dtsi. I'm not sure how to make th1520.dtsi dual
> license. At least, this needs help from Guo Ren. Any suggestion is
> appreciated.
> 
> >
> > >
> > >
> > > > +	memory@0 {
> > > > +		device_type = "memory";
> > > > +		reg = <0x0  0x00000000  0x1 0x00000000>;
> > >
> > > There's some extra spaces in here for some reason.
> >
> > Thanks for spotting that. I'll fix when I resubmit with dual licnese.
> >
> > Drew

Kwang

