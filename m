Return-Path: <linux-kernel+bounces-12873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684F81FB9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 23:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A733B22FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262410A01;
	Thu, 28 Dec 2023 22:41:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECE107BC;
	Thu, 28 Dec 2023 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 1DD4D84630;
	Thu, 28 Dec 2023 23:36:16 +0100 (CET)
From: Duje =?utf-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hardik Gajjar <hgajjar@de.adit-jv.com>,
 Richard Acayan <mailingradian@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] usb: gadget: u_ether: Re-attach netif device to mirror detachment
Date: Thu, 28 Dec 2023 23:36:02 +0100
Message-ID: <6019329.lOV4Wx5bFT@radijator>
In-Reply-To: <20231218164532.411125-2-mailingradian@gmail.com>
References: <20231218164532.411125-2-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=duje.mihanovic@skole.hr;
 keydata=
 mQINBGBhuA8BEACtpIbYNfUtQkpVqgHMPlcQR/vZhB7VUh5S32uSyerG28gUxFs2be//GOhSHv+
 DilYp3N3pnTdu1NPGD/D1bzxpSuCz6lylansMzpP21Idn3ydqFydDTduQlvY6nqR2p5hndQg6II
 pmVvNZXLyP2B3EE1ypdLIm6dJJIZzLm6uJywAePCyncRDJY0J7mn7q8Nwzd6LG74D8+6+fKptFS
 QYI8Ira7rLtGZHsbfO9MLQI/dSL6xe8ZTnEMjQMAmFvsd2M2rAm8YIV57h/B8oP5V0U4/CkHVho
 m+a2p0nGRmyDeluQ3rQmX1/m6M5W0yBnEcz5yWgVV63zoZp9EJu3NcZWs22LD6SQjTV1X8Eo999
 LtviIj2rIeCliozdsHwv3lN0BzTg9ST9klnDgY0eYeSY1lstwCXrApZCSBKnz98nX9CuuZeGx0b
 PHelxzHW/+VtWu1IH5679wcZ7J/kQYUxhhk+cIpadRiRaXgZffxd3Fkv4sJ8gP0mTU8g6UEresg
 lm9kZKYIeKpaKreM7f/WadUbtpkxby8Tl1qp24jS1XcFTdnjTo3YB2i2Rm9mAL2Bun9rNSwvDjE
 fjMt5D5I+CIpIshaQwAXwRTBJHHAfeEt62C1FQRQEMAksp4Kk1s2UpZkekZzNn48BnwWq75+kEj
 tuOtJIQGWTEHBgMG9dBO6OwARAQABtClEdWplIE1paGFub3ZpxIcgPGR1amUubWloYW5vdmljQH
 Nrb2xlLmhyPokCTgQTAQgAOAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFPfnU2cP+EQ+
 zYteJoRnrBCLZbhBQJg01LLAAoJEJoRnrBCLZbhMwoQAJBNKdxLxUBUYjLR3dEePkIXmY27++cI
 DHGmoSSTu5BWqlw9rKyDK8dGxTOdc9Pd4968hskWhLSwmb8vTgNPRf1qOg2PROdeXG34pYc2DEC
 0qfzs19jGE+fGE4QnvPCHBe5fkT2FPCBmNShxZc1YSkhHjpTIKHPAtX1/eIYveNK2AS/jpl23Uh
 hG9wsR2+tlySPNjAtYOnXxWDIUex8Vsj2a2PBXNVS3bRDeKmtSHuYo7JrQZdDc0IJiRm0BiLEOI
 ehTtcYqYr1Ztw7VNN2Mop/JG2nlxXNaQmyaV6kF/tuaqn1DJQcb0OxjAXEUMaICYJOwS9HSt26n
 uwo8dUiUPLQTih/wm6tyu2xrgMwqVT5jiKIssSS+7QNTsmldubRSYjFT49vwkVoUQ6Z3UO6BVdd
 f3OG4meE0S5uQc7Moebq67ILxfQ8XsDvdvEliVuHh89GAlQOttTpc6lNk8gCWQ+LFLvS66/6LFz
 mK1X4zC7K/V6B2xlP4ZIa3IC9QIGuQaRsVBbbiGB3CNgh0Sabsfs4cDJ7zzG1jE7Y4R9uYvdSFj
 Liq5SFlaswQ+LRl9sgzukEBTmNjdDVhufMY2jxtcMtck978E1W1zrg94iVl5E0HQZcpFHCZjRZX
 Fa42yPsvVkFwy4IEht9UJacMW9Hkq5BFHsdToWmg7RY8Mh04rszTiQJUBBMBCAA+AhsDBQsJCAc
 CBhUKCQgLAgQWAgMBAh4BAheAFiEEU9+dTZw/4RD7Ni14mhGesEItluEFAmCVBxAFCQXW6YEACg
 kQmhGesEItluFXIg//QnqY5RrQ1pLw2J51UwFec4hFMFJ6MixI9/YgizsRd2QLM7Cyi+ljkaHFQ
 mO4O5p0RsbF/2cc4u1D+MhQJGl6Ch6bdHoiWFrNUexgBUmflr4ekpI+GIFzikl6JTYHcRfkjobj
 0Tmr8zWoxzcdFhrzGn5/6AH3GxudpUr6WQD5iDSe43T7ZcY8zHfD+9zcsZ2LHhRhpHU0q+ERQw+
 Rnh7C3urXlrAlFzuKuPh2tHT76glRaledJ8cK34vHNi73TYpsFy4tfhAPhHwBogtjBf63jBOd/E
 S6wuYpKwcfNXo9EuEpJzJOitFwOvAra5AbCE+N/C/IOu2aFeOyu2SbHro06+Eyf/jy1A2t+LgLb
 E5cZu5ETyicfpN8L7m7wTTXTSx0NhETNWfgV95RUI6WIW5N4OCOVo8d/GOMVEYqMoDZndQin9B3
 lDgojyagdzhXljP2BqavKdnPWbcKQ+JViR+e7EjLWVifgZkAvEhyirbTKYsgKkaRxoQP68U0bEy
 ukygDZRdzBmWaZPqBOzA5AH+OYiYVzzFqdBAHr2+z4mTN6W0td7CFDRAS2RzQApO3B1QH408Ke9
 Oy69HwG+gdlfwloN6JTvgr5vQc8T6e3iC3Be/guLyW5UbLPxyFHimznVOizDYbZO1QSZMqk4G9I
 gA8e05P8dxEQJUsdZFtDdNPOYm0IER1amUgTWloYW5vdmnEhyA8bWloYWR1amVAcG0ubWU+iQI2
 BDABCAAgFiEEU9+dTZw/4RD7Ni14mhGesEItluEFAmS+bsYCHSAACgkQmhGesEItluFe1A//RYe
 e+k0WwL80kgCbnZGJ5USmVBfa0+XFi2PWtCv1EQamT+RXkD8mGw2a5Tjk45RAJfKkD9Ko/OXaDW
 yN5yWfRAIcGazsYb0VPfLpTZTuTIRtQ9ui2UxGDzzVhntEMgNayNVMFUm2xxsZcZI80mF/sH/Ho
 f+FV+C4xkRGidosMcehZvwNH5ATes/vF1LE3FkW9Bw5tQkbyX79svPsWkF2/gTzJZAqg0BKPhU5
 uFQMAvy/TUrramWgjN6/QzYgOrfq55mciCrhtaixhgu/7e4uQhqFcJypgQxfF2uiL6C9kaWj4qd
 bLToUpeFMEa+9MQiF+tfQRPnRwb8NgQLvxPf8ORyX/3nB7N1Yg0slpnvHXYs3KksDk7iPTlUjl5
 3//L690B2KLTDMVZu5Lr6vad8+8JcPe4OfmsVScV4h00dS03pnp9bEX066X/J1TGWUTsnapALa4
 HpaCFlbkoGFh3AxiFEvV8SegJKDFv0a0lsUixbcrQIpGynIdDuAPfxu7aBMDtjhpmXulIeIit3z
 uLmREt5Q/IZq+7BaKKOpNfEDB4iUpzUDoNKrx9IUfvaXIK7WO+D+RjjtIDEUkWWbssQIlAIQxgL
 zcDx72IEAcnenMRfr6e55VRIILdpTBI8cc6dLuux1q3xdSPSWmKOpe4+whiU4XvVlKZpfm7x3wa
 tgI5iJAk4EEwEIADgCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQRT351NnD/hEPs2LXiaE
 Z6wQi2W4QUCYNNSywAKCRCaEZ6wQi2W4XLMD/9dNLW60le/yVyx4CysGVGcq1qafrcJZrSk2WLi
 OhKpZJR+GiEv267hCeiOsfLEPlAfu4aHoMTN+CRol4U8Yr6i1O4OK5n599f5af2DNj5JeXwDBcX
 RmFRg+TCN9HBOtB9wnIWG2WI7gNFSaEHmlWH6Jltdwkbhez02bGfSDw1Hu1IK+SBAXdZQH4NrmJ
 HFuNA2HjQUtjZWfmvtiRUCVaogc6ShuoV8YPc4Ru4Tg2EKIcEvI1VG7dg7FGRu3z3x8U2t8ZHVJ
 ucd4qs9eXo6GL3EJpRjvsjzSGDOtJQmJdfzYgt1k/BENz/YGN9lqILy8FuXf5CFLqBiCHD+Jl68
 LekyoDbwNqJ69GAU6tjcJ93SLMsHMJunWru/H2ZoIJGDpwnNGKxItrLHLE71M8365Ib+zgzrMJB
 7NiB9NeCnSV3Memx8Lxb7jucyaGr+UM//D5oNa8yhtEEesW7b1O0dxBB6UWLQaxkYfwo92+KBho
 QmYATqN1vRD3l/RpArbQmr14hw+BupBTWo0v+Qj2SLxjPNnKeTfJQTaw/s3vpmRlPpOPZctBIyB
 DJvYl9GEbb5fWegqgEDFBn5u1g81280Ur37zVxOJ8Flhu0P/lW+/py2jhOGiqahbnyk/JkRrn6/
 C4jKf54rc6fhxRw5E6zueZb3BL437WliiJDHaQKzdlQWBIkCVAQTAQgAPhYhBFPfnU2cP+EQ+zY
 teJoRnrBCLZbhBQJglRA6AhsDBQkF1umBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEJoRnr
 BCLZbh5zYP/12YN9jwdkzfperikRWE02zpkoAFdC3s4xaanDiLF2HfA04LlQnxV2laMLlP3+gwH
 Tnll1LJb9W+s4VEbrapF99+xukPa6L3SFPMAiy4ugWuwjiAO6TAYz6BYL3xi+JA877M8ZAqJ6bo
 xzH5MhjhfkXyjLwrBBQZD7lbrSlrlE90YObpXudyjuoG2ct3ghQ9kqxvyBfkMLbRRLesTgomhqQ
 DJ84DZ1o6i4R2QUEYVF20KQej9bca7LfYn35GtCkhJBg4TM9dj0QMr5G3kSyrO0bV1lOOCzNGJd
 3vlLHH/bjQ23bFIqaC11CSD+Ka3eluGPfqOCtxnkWmYLVHcMkbQnlNX9MyFEhD7pMfkh1JeJU0b
 yAenIdw0Rl5PKLZdx0np4CzokvOABXu1+paK7ftVt/ycrQhRRW58CnF4F3Li2cx9JgTJhM0FkIZ
 zBg5H0HMYE0tk2/VLXM+i3kx0ynANvP/CmM1wdJsnjBglyxHBpzlZQESPXhUrOKFEKyoA1ii1PC
 ktk1SsRFhRT6AyrD2gdgsNsKBmasFQWdcpUo84wmz8QFJEACehAa2fhm42nLfW1wkpWvQ6RUU6M
 fdHgG5E4siUPoAHYvfgEtwZWpve5tY2kL3mReYcXcq8PAhHEnLSOdZL7nx8CM+OjMC7WXN19FQW
 wdOflaI8ryiJvUV0wrvuQINBGBhuA8BEADA9GztLvWqZiNVjpONSHVNR3O+hy1APY7IgX3wPcmd
 TqZxRCAMEnlDvDxSu1uWD3Ua3jbFLzJgYiyYnfctLVubAAo0qx/mpgkJdISdypRJK/lbloGtWvm
 HtKs4PO20Gnu+vUYcMxD70L7zaE8U7b0+QJYNqdyUr+Xf8Atk7vSKBSpAwCKAhbL8rbma9i7h96
 Cue6E4YWxKIGF0e2CdCSMFYO5zkF56qVE88ZIf+9xSjegcdNZt+6Qd8E3vMN8PK/FjoqaEVPmj1
 oWnwzRa3cgX0lTgMN35l/cgHxX2aOMPTk3ZKyy3Sukpl+5qojLLaGZ72SKS0ZPy9GTayfHwFQ/n
 xHKVIgqCsIomNEBQlrpjFyE3g+M5aP2OpUCoVKehGNJHIxtQ+5+bAUeaEHLAvT5R/Wtdi/rTSH5
 Y2sohFaG5pD8Bn+ad7MTqnpLOllqAffmSJPPPJEHSP2+1QP/OkL7E6rm6Sba+blTbcso2WEwRxZ
 xBnAOfkbNiv/E1hWAxAWYsm36Qsa2E9kXUxe3n9sEGQIjWYc2hMMa+0uGExbgsMKmii7b3JBr9n
 7BVMt6ntvLcPd6AjUMUqoDqukQ9B325VYl3oqMj9Z1lSwMeqWku3d/E0+nM9ByQrTjBZ0vlKSQ7
 9sd4EXgjwaKkcey1eGmDMhsuKc8HrPsjvO4cVC7cPwARAQABiQI2BBgBCAAgFiEEU9+dTZw/4RD
 7Ni14mhGesEItluEFAmBhuA8CGwwACgkQmhGesEItluHXuA/9GgsROHU5jtcUOgQ15SqQwnoJPH
 SKq8SvBHW3avf1hkjuibNEHyC+dCBwEe9/RW0nE+PqEjm3oNGqfZAhn1tAFxmWlPNhHdebvjM4J
 LBxPrfHIFC0yo6qrfj16tMsWXy8CPYrU2t8xNnelMXeFc6u+440Lgy+qN8zOgUEyRmMcUuphCxJ
 XJzJaPZSGSswgB2iJJDJTDQX75vEPdmgrkO+cY1oYrPSvZclfXEGX7vAMj+MzBhZOdGebRBdlBc
 pairvr/BWYns74sLvTbGXoCGOA0Wj1heRlphYWFOHvYARRucYRKCJTvnrbtZ0hNVCZPq5ryS9tL
 ijVD54V0yWkE8wAqQNf9hag5zlFMfKjmKphzJRbstqlIf0B0oY3NgLZ4ExWa8wJxs+p4pUZd9m+
 6fDfimjuLtlBphjsHfwrgs69g8RqJlEsgsDrWu7zsWraK/jTyuPK6GuNe4AWemRUaZZmhMYnCxU
 p8AXRgtzZw2vsqERylx1Ug35G/xRIVrjf9bU2fersVWLR3JZ/rJwdjev4cJqzqJ9nBzblHky3K1
 cqiNEM/CU+JLBsZMc4jti/3tDv8VKfZiwLMIsVrfPgTM/97CCW3QDwVcreUGx81kemiAweXENWk
 MGQfJ+8rfAdLHf7iECLWLtrqyfYFQCZGhA5rPPr27TjOLaLV5ObMMBsUY=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, December 18, 2023 17:45:33 CET, Richard Acayan wrote:
> In 6.7-rc1, there was a netif_device_detach call added to the
> gether_disconnect function. This clears the __LINK_STATE_PRESENT bit of
> the netif device and suppresses pings (ICMP messages) and TCP connection
> requests from the connected host. If userspace temporarily disconnects
> the gadget, such as by temporarily removing configuration in the gadget
> configfs interface, network activity should continue to be processed
> when the gadget is re-connected. Mirror the netif_device_detach call
> with a netif_device_attach call in gether_connect to fix re-connecting
> gadgets.

This fixes the NCM gadget on the PXA1908 phone Luca mentioned on v6.7-rc7.

Tested-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Regards,
Duje





