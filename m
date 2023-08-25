Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7797884ED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbjHYK3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbjHYK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:28:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACDDE67;
        Fri, 25 Aug 2023 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1692959298; x=1693564098; i=wahrenst@gmx.net;
 bh=k5qoGE4dPXibVOr3vbK/MFYzKHRbviky7F+alf86o64=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dRmtmorqsr94xZrNHs56xNvgcXYUiF4AM6qUDzXTbwEI+491ZPPg7t7brDHAMMerHs6SzCg
 OLlZLQWvSLffPgLJlTDtqlxZS0Ut8IU925fqaEEH1OCKe+1tVdnRhSDutk62WQ8J3a5SNrl1Z
 qUDoth7HK1pUsWTPu+4Dv46Yn5DlR13nsyNtlnnCwpI31Ldrlzt627EFvyG/sg1qJh3NMwy/i
 fKN3x0WEtAKcf4JcLEo0k53UaYmaThymy+9+d1E/PZ5l5tbCvzfxJlfq048reYrf0m1ad5hnZ
 zm4mF3DZlq/jRk5476qspu+Epjqaw8PJPSgLajfdJbDfurp70uFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNt0M-1qKB4M2EkC-00OJA5; Fri, 25
 Aug 2023 12:22:26 +0200
Message-ID: <f7a1252f-d043-b197-6d21-2a603d928da3@gmx.net>
Date:   Fri, 25 Aug 2023 12:22:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 06/11] firmware: imx: add driver for NXP EdgeLock
 Enclave
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, wei.fang@nxp.com, peng.fan@nxp.com,
        haibo.chen@nxp.com, festevam@gmail.com, linux-imx@nxp.com,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     kernel test robot <lkp@intel.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-7-pankaj.gupta@nxp.com>
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20230823073330.1712721-7-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/3g46wka99ef0GHi5iaaBRud3jyEYUA2Ob5RlCoyBKXFgTpkQ38
 YDbKUnMLWCm2bCShYx8R/zMzNMaefhywhlF1iA7rQdCFt7OLFSCwezOVJPlNBP5sW+YDegT
 ezOfZdRXi1mLuBIXM1mHqWgulvAN530QLJ144juN5oEMm5aCg6I2RxrtuATp5nPZ8NzsSty
 4XjT7/pR/g5r2fwWfdNOg==
UI-OutboundReport: notjunk:1;M01:P0:SSlk7Glwg3Y=;LRNkAL1tbpSrTUjcTWD5jtK0lvI
 RpYbugfMwFBrVqqZNMylCBWz737SKrNF/IdelQZP7wXS9dbMRdouTUCJABMiZJzHOf0hsD9GE
 Vv/StWqZyXxMxWUIinEx0LM9d4cKpeM3SJHGSGbIiQrJOoJW/HEejumkqGmi0LbyOTTdyqWQs
 7Z6kvJ0TPgJ8ZpCe0fasDrCU2WyH4dKgSbHe32s7OdzSFYxZ8VDslrCKKKTk2OwY7nn91h5h6
 YANJ0Cp/niQ5g2BWBdafiDVBbcEWpKXfHFlCR5r8vYLeKhXCsbOX+9RFcEyHh3dOJBL6rJXiS
 F82zOnOx7EBUqLdQOPlY8IwiST+SfNjp/CkjARhaZ6AJcw0XXvZvAV+6PF8DQd8amy/4iQ46L
 rGF3hSjAT19tkzO4+fhBGYJ8QuWuZ1R6lvsh8p56FYyVPFiZaKDZAgHhl7F8B/SJ0DDayNz6K
 hVNr1bPd7/lrfmdSS9E5G8KFJtpdspcyhqbL2Wkn3Ikntxlepdb3YAuR+jHcu8TaHdhXPM0O7
 rkGO5quB3zyRA1EfmkcCrlvfR7CYZyPqXTCLsIXHCJ9z5bW7wm3YvKvCxn5k1Yia+P2M61YDR
 fhWBRnIp9LByGx6tEjBJz/qzyVOq1pphJ/2YW2pW4wh9WRvKMhqRuC3OCqydDJ4vQu+ECuTvc
 gSTmxtipslgZuiMA0Jcp5IYZGMCGIgTvzzWkfFJ/Ox/z89oM6kMFrb1Gko9Fg2rsG9X6dBJTW
 2dgnTbodNE+oC/kYhfhSJaENkJIlEmSU4auePaeYTJ0XP+XN3i0+X4NmHYaw4xnfex5KTlUUQ
 WqFroWZkY/CHFB7K2nTZHHkhI3EMvM8AUGOZj/ZJ8d1S6lIQSbVawQDpkQjWM30U2qyfyP+mh
 Z03XnknkN5bPMhTvspEyBrTGdHN6ah5AZAXK+MW3UwtlowfNs16ZHvFksGrFTyVZJHMz1vwIJ
 LHbVEpR/Wu86fC5NDsuFrGBRn2A=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pankaj,

Am 23.08.23 um 09:33 schrieb Pankaj Gupta:
> The Edgelock Enclave , is the secure enclave embedded in the SoC
> to support the features like HSM, SHE & V2X, using message based
> communication channel.
>
> ELE FW communicates on a dedicated MU with application core where
> kernel is running. It exists on specific i.MX processors. e.g.
> i.MX8ULP, i.MX93.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:https://lore.kernel.org/oe-kbuild-all/202304120902.bP52A56z-lkp@i=
ntel.com
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>   Documentation/ABI/testing/se-cdev         |   29 +
>   drivers/firmware/imx/Kconfig              |   12 +
>   drivers/firmware/imx/Makefile             |    2 +
>   drivers/firmware/imx/ele_base_msg.c       |   62 ++
>   drivers/firmware/imx/ele_common.c         |   34 +
>   drivers/firmware/imx/ele_common.h         |   21 +
>   drivers/firmware/imx/se_fw.c              | 1201 +++++++++++++++++++++
>   drivers/firmware/imx/se_fw.h              |  168 +++
>   include/linux/firmware/imx/ele_base_msg.h |   37 +
>   include/linux/firmware/imx/ele_mu_ioctl.h |   52 +
>   10 files changed, 1618 insertions(+)
>   create mode 100644 Documentation/ABI/testing/se-cdev
>   create mode 100644 drivers/firmware/imx/ele_base_msg.c
>   create mode 100644 drivers/firmware/imx/ele_common.c
>   create mode 100644 drivers/firmware/imx/ele_common.h
>   create mode 100644 drivers/firmware/imx/se_fw.c
>   create mode 100644 drivers/firmware/imx/se_fw.h
>   create mode 100644 include/linux/firmware/imx/ele_base_msg.h
>   create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h
...
> +
> +int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size)
> +{
> +	struct ele_mu_priv *priv =3D dev_get_drvdata(dev);
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	ret =3D plat_fill_cmd_msg_hdr(priv,
> +				    (struct mu_hdr *)&priv->tx_msg.header,
> +				    ELE_GET_INFO_REQ, 16);
> +	if (ret)
> +		return ret;
> +
> +	priv->tx_msg.data[0] =3D upper_32_bits(addr);
> +	priv->tx_msg.data[1] =3D lower_32_bits(addr);
> +	priv->tx_msg.data[2] =3D data_size;
> +	ret =3D imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag =3D MSG_TAG(priv->rx_msg.header);
> +	command =3D MSG_COMMAND(priv->rx_msg.header);
> +	size =3D MSG_SIZE(priv->rx_msg.header);
> +	ver =3D MSG_VER(priv->rx_msg.header);
> +	status =3D RES_STATUS(priv->rx_msg.data[0]);
> +	if (tag =3D=3D priv->rsp_tag &&
> +	    command =3D=3D ELE_GET_INFO_REQ &&
> +	    size =3D=3D ELE_GET_INFO_REQ_MSG_SZ &&
> +	    ver =3D=3D ELE_BASE_API_VERSION &&
> +	    status =3D=3D priv->success_tag)
> +		return 0;
except of the coding style, i won't recommend this error handling. In
case a user report a failure of ele_get_info(), we need to figure out
which of these conditions failed. Why not check the conditions step by
step and give a detailed error message.

The same applies to the rest of the series.

Best regards
> +
> +	return -EINVAL;
> +}
>
