Return-Path: <linux-kernel+bounces-19641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A5D82702A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51D71F2322F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6661745947;
	Mon,  8 Jan 2024 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Nzu45zx7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDBF45941;
	Mon,  8 Jan 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
	s=s31663417; t=1704721594; x=1705326394; i=frank-w@public-files.de;
	bh=eHFTTnrAlxZxsnvH49LqdXsKFSZ7Cww6ornO/kw2wR4=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References;
	b=Nzu45zx7TGWivSS7zIVmVRMzMRk2B9poNz47OhalBWl/jadI7bUDH5bEc8Y6zVOi
	 3SH41JApS5KTBKRnGS1JdHCjnvn8lqPVKN79D695LFi1C//6O+/SORTwX4fl3dZJD
	 DZnTAxyn5NWu4CgQX1MRbIQadJCMJYUBUsvM3glgjWEHZSlBIMPxfzdZuAF/iNLNw
	 HchtxXDyBW9czu9+7RxMIDIdG9xGFhrbcngLGSUWPIXoeNvJy3zBQUh1siHGUAlgN
	 +fy1no13Mi1waJl54T+eAUQZGhMKJtdjEAaRzFZrDt1NO5B8IlDpfZRuhfRIAGkD7
	 3DfRMgspDTUF+t39cQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [IPv6:::1] ([80.187.71.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFzr-1rWQKj44DF-00AHf2; Mon, 08
 Jan 2024 14:46:34 +0100
Date: Mon, 08 Jan 2024 14:46:17 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <linux@fw-web.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
CC: Sam Shih <sam.shih@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_clk=3A_mediatek=3A_add?= =?US-ASCII?Q?_infracfg_reset_controller_for_mt7988?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <717a21bb-de39-4f7d-913c-f2a20d8b02bd@collabora.com>
References: <20240105162056.43266-1-linux@fw-web.de> <20240105162056.43266-3-linux@fw-web.de> <717a21bb-de39-4f7d-913c-f2a20d8b02bd@collabora.com>
Message-ID: <D0CA0019-A61D-4843-B502-7F40DA619FB3@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xblEkwWVshSiG/6u0lgUW6oJn5QhPXUSO4eD2KMSmL3wRJcRLMH
 N52WYGxVpESAKG26Qc5C0MuKrWlqmrURECmvc4GnzGt9lwnwy27vrdLzDrlXEgANOKfq6uk
 bDz2NHK/9fUaUeA7HaRsDDfp9fnPpUX/3a+WxuhbWPM8AcsZc58J8UAj9j3MNUoX5R1rpyD
 rQRWLzvjH3ZEg0N2VWDUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UHoxeZHGFCA=;zNPt/J3l03QqhDyB7HxtL7N9zr4
 NA8NfUJbGXxSCURvNbWIP13RBD1w8aha9xpnzf3RuoIEmLZOnVU7tcJGT5ABNsEvDjo+V/rbg
 4S4A7/qReBDzO4pjGWDqyWvK/CzpWnlt9BYpuCQnxUxcQEZ1NJ1Tg/XpfRZkSXfIhHZuF4Scu
 p023r/UsyLcF+GfZ18YKyEuNXsOiD0u+/LR3rorNhNBCh5kEi2d3Vm9hLaOeQwTu+1PnvZsdY
 krSDiDizdIXOo7ySGRr38dVsceK3YxrRuGFMAsJt5jRE9FMHCxo+563TfWlGDXcCccUfeJl2r
 nJhCNrG8kOmFPi6Zl2fjRtDYJQ8bclKit1OXTjCrzJvSvJmlyXQWc64zP/ffePBvBRwKPoQar
 bDIFY1dt64NJCeG6RVDCza417fRzl14DfRc324Z43utKSlIhswr2crEAf/P51kzDC0WZrnHrO
 6yGsg1OWsK9aCR9d0NkvVW1o6/LswUyGlvKevmWIiSn94KL4WPKiWH+nlhMqDYB/RnyYCZDf+
 0Wd+ZJ7tn387ZIqq++rnSepwo6T9H2bxhlT2o9RwXx0Uqa2+nTA6u+5GvIpK2OszC5cb+knx0
 D0dVrX9P49ADAswF/dNBJR19J5x6bVBbrgPm5IJ+YH8Tr4h/I5zxe6lnCqlFqStOFQ2FVh0+H
 LXZ5N9YFxCxmqbirPh8rSMyBp1XVH4yLHaaDxMcDyVUMCnXT26IGh65Cwn3JM5p/JhwmkzqzJ
 HwlVXigIwOtGblAEs2ca6HsWXgHY+7yc/ows9rLksLNrw6h+coYyKYF2mgWnF4XmKeST/lnBp
 g7aHpZsoyR6aMqLb4vP6bwzKsc8X6RV+my67Pn9FwxoYn++Ng4Um7JmAIXk/Seh4RY51woWBk
 85NpLVxq/u3itttkE3DiUt6bKTI8os87bliwvFwQRsNL3MYEZwCle/ZBlO8TNhIuLn/2q9Wne
 ivecCg==

Am 8=2E Januar 2024 11:12:26 MEZ schrieb AngeloGioacchino Del Regno <angelo=
gioacchino=2Edelregno@collabora=2Ecom>:
>Il 05/01/24 17:20, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Infracfg can also operate as reset controller, add support for it=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>   drivers/clk/mediatek/clk-mt7988-infracfg=2Ec | 20 +++++++++++++++++++=
+
>>   1 file changed, 20 insertions(+)
>>=20
>> diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg=2Ec b/drivers/clk=
/mediatek/clk-mt7988-infracfg=2Ec
>> index 8011ef278bea=2E=2E1660a45349ff 100644
>> --- a/drivers/clk/mediatek/clk-mt7988-infracfg=2Ec
>> +++ b/drivers/clk/mediatek/clk-mt7988-infracfg=2Ec
>> @@ -14,6 +14,9 @@
>>   #include "clk-gate=2Eh"
>>   #include "clk-mux=2Eh"
>>   #include <dt-bindings/clock/mediatek,mt7988-clk=2Eh>
>> +#include <dt-bindings/reset/mediatek,mt7988-resets=2Eh>
>> +
>> +#define	INFRA_RST_SET_OFFSET	0x80
>>     static DEFINE_SPINLOCK(mt7988_clk_lock);
>>   @@ -249,12 +252,29 @@ static const struct mtk_gate infra_clks[] =3D {
>>   	GATE_INFRA3(CLK_INFRA_133M_PCIE_CK_P3, "infra_133m_pcie_ck_p3", "sys=
axi_sel", 31),
>>   };
>>   +static u16 infra_rst_ofs[] =3D {
>> +	INFRA_RST_SET_OFFSET,
>> +};
>> +
>> +static u16 infra_idx_map[] =3D {
>> +	[MT7988_INFRA_RST0_THERM_CTRL_SWRST] =3D 0 * RST_NR_PER_BANK + 9,
>
>The MT7988A datasheet says that INFRA_RST0 bit 9 is CONN2EMI_M0_GALS_SLV_=
SWRST, so
>this is wrong: THERM_CTRL_SWRST is in the RST1 register, bit 9=2E
>
>Also, I'm sure that you really want to add the PCIe MAC reset bit as well=
, to be
>used with the PCIe driver=2E=2E=2E
>
>[MT7988_INFRA_RST0_PEXTP_MAC_SWRST] =3D 0 * RST_NR_PER_BANK + 6,
>[MT7988_INFRA_RST1_THERM_CTRL_SWRST] =3D 1 * RST_NR_PER_BANK + 9,

Yes you are right=2E=2E=2Ei have only rst1 as screenshot,need to get the f=
ull datasheet or can you tell me base address for rst0? Need to change valu=
e of INFRA_RST_SET_OFFSET then to rst0 and check RST_NR_PER_BANK to be corr=
ect=2E

>Enjoy=2E=2E=2E :-)
>
>Cheers,
>Angelo
>


regards Frank

