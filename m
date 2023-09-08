Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C247982CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbjIHGyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjIHGyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:54:14 -0400
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1478C19AE;
        Thu,  7 Sep 2023 23:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1031; q=dns/txt; s=iport;
  t=1694156050; x=1695365650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GTpjVFDJIhZ0PXZwy0GbbXZ2owdqy1b93LfpRJW8HCU=;
  b=C8Z2Tir11E+wRZcmMB6Jp2eDNUAVoVtQP6WLYB0DPz/pTbhi+O2g8k1U
   z6kOIzUg8rOWCNe8YnJKcVYWusBL7xWokC8/qiHonOtZGTAtzBW+GIXiT
   2BTSmO7zwhzK36wgOngWROd92R8Tj0UCKcq6dmyYQVvrJ74MbA+QqZzzT
   s=;
X-CSE-ConnectionGUID: iliA1cAyTCeUmazCQZhHCQ==
X-CSE-MsgGUID: OYJAK9LkSLGTh8k+fVgS7Q==
X-IPAS-Result: =?us-ascii?q?A0DOAgC0xPpkmIoNJK1aHgEBCxIMQCWBHwuBZVJ1WyoSR?=
 =?us-ascii?q?4gdA4UtiGede4ElA1YPAQEBDQEBRAQBAYUGAoZxAiU0CQ4BAgICAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBQ4QJ4VoDYYEAQEBAQMSK?=
 =?us-ascii?q?AYBATcBCwQCAQgRBAEBAR4FCzIdCAIEDgUIGoJcgl8DAZ0CAYFAAoooeIE0g?=
 =?us-ascii?q?QGCCQEBBgQFsmwJgUeICAGKBScbQIFNgViCaD6CYgKBYoQSgi6JUoVBBQIyg?=
 =?us-ascii?q?imDNCqBGIggKoEICF6Baj0CDVULC12BFYEogR8CAhE5E0dxGwMHA4ECECsHB?=
 =?us-ascii?q?C8bBwYJFy0lBlEELSQJExI+BIFpgVMKgQM/EQ4RgkUiAgc2NhlLgmMJFQw1T?=
 =?us-ascii?q?nYQKwQUGIEUBGoFGhUeNxESGQ0DCHYdAhEjPAMFAwQ2ChUNCyEFFEMDSAZLC?=
 =?us-ascii?q?wMCHAUDAwSBNgUPHwIQGgYOLQMDGUUDRB1AAwttPTUUGwUEZlkFoH6CWIEjg?=
 =?us-ascii?q?TBsD8UZCieDZKE7F6lfLpcId6gcAgQCBAUCDgEBBoFjOoFbcBWDIlIZD44gG?=
 =?us-ascii?q?R+DQI95djsCBwsBAQMJi0gBAQ?=
IronPort-PHdr: A9a23:0+3RmRWwEM8NamdBCSRRld44UGXV8K0yAWYlg6HPw5pHdqClupP6M
 1OauLNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2si62vq7553USw5JnzG6J7h1K
 Ub+oQDYrMJDmYJ5Me5x0k7Qv3JScuJKxGVlbV6ShEP64cG9vdZvpi9RoPkmscVHVM3H
IronPort-Data: A9a23:jOZwpKggoHhx6lHxF20wPjVQX161rBAKZh0ujC45NGQN5FlHY01je
 htvWW6HafyDMGH2f90gO9mw/UgHscKBytJkHAFuqHswQS9jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+1H1dOCn9CEgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZWFULOZ82QsaDlMuvrc8EgHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 woU5Ojklo9x105F5uKNyt4XQGVTKlLhFVTmZk5tZkSXqkMqShrefUoMHKF0hU9/011llj3qo
 TlHncTYpQwBZsUglAmBOvVVO3kWAEFIxFPICXm7sOXKxGTXT1Dh/vBnHmoPD4040d8iVAmi9
 dRAQNwMRhmHg+Tzy7WhR6wxwM8iN8LseogYvxmMzxmAUq1gGs6FGv6MvIQItNszrpgm8fL2a
 8cUczNzbBPoaBxUMVBRA5U79AutriCiKWcE8wrE9MLb5UD0/S5Y8+nJM+HxVeCKFcYWkHiXn
 T3/qjGR7hYybYzDlmXtHmiXruvOmz7rHYEfDru18tZ0j1CJgG8eEhsbUR28u/bRolWiUthbJ
 mQK9Sc066s/7kqmSp/6RRLQnZKflhcYX9wVGOog5UTQjKHV+A2eQGMDS1atdeDKquc3QT0Dj
 1Sgju/CCAFqua++cECd1pyt+Gba1TcuEUcOYioNTA0g6tbloZ0ugh+ncjqFOPPq5jESMWyuq
 w1mvBTSlJ1I1pZajfXTEUTvxmPy+MSUEmbZ8y2KBgqYAhVFiJlJjmBCwXHf6ftGRGpyZgbc5
 CBe8yRyARxnMH1gvCWJRONIF7az6rPYdjbdmlVoWZIm8lxBGkJPn6gOulmSx28wba7onAMFh
 meP4mu9A7cIbROXgVdfOd7ZNijT5fGI+S7Zfv7VdMFSRZN6aRWK+ipjDWbJgTGxyRF1zfpvZ
 c7BGSpJMZr8Ifo9pNZRb7lFuYLHOghirY8ubcmhlk/+geb2iIC9EOldbjNikdzVHIvd8FmKr
 L6zxuOByg5UV6XlczLL/IsIRW3m3lBlba0aX/d/L7bZSiI/QTlJI6aIndsJJdc/94wLzbigw
 51IchICoLYJrSeZeVzih7EKQO6HYKuTWlpgbXBzYA30iiN7CWtthY9GH6YKkXAc3LUL5dZ/T
 uIOfIOLBfEnd9gN0211gUXVxGC6SCmWuA==
IronPort-HdrOrdr: A9a23:N34DsKryTG9aq/DtL/GMrLkaV5tuLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6HwBEDhex/hHZ4c2/hpAV7QZniXhILOFvAt0WKC+UyuJ8SazJ8+6U
 4OSdkCNDSdNykcsS++2njHLz9C+qjHzEnLv5aj854Fd2gDAM8QinYcNu/YKDwIeOAsP+tAKH
 Po3Ls8m9PWQwVtUi3UPAhiY8Hz4/fwuNbNZxkACxQ76A+Iow+JxdfBeSSw71M1aR8K5a0t31
 TkvmXCi5lLtcvV9jbsk0voq7hGktrozdVOQOaWjNIOFznqggG0IKx8RryrplkO0aKSwWdvtO
 OJjwYrPsx15X+UVHqyuwHR1w7p1ytrw2P+yGWfnWDoraXCNXAH4ot69Mdkmynimg0dVeJHoe
 R2NqWixsNq5Cb77WDADh7zJklXfwSP0CEfeKUo/g9iuMMlGc1sRMokjQNo+FNqJlOm1Gjhe9
 MeVv309bJYd0iXYGveuXQqyNuwXm4rFhPDWUQavNeJugIm1kyR4nFojPD3pE1wv64VWt1B/a
 DJI65onLZBQosfar98Hv4IRY+yBnbWSRzBPWqOKRC/fZt3d07lutry+vE49euqcJsHwN87n4
 nASkpRsSo3d1j1AcOD0ZVX+lTGQXm7Xz7q1sZCjqIJ94HUVf7uK2mOWVoum8yvr7EWBdDaQe
 +6PNZMD/rqPQLVaM90Ns3FKu9vwFUlIbooU4wAKiezS+rwW/nXitA=
X-Talos-CUID: 9a23:Y79tKWFt+8ZxUymnqmJm8E89Q8sMY0H2wUrVKl2TMFRpaJasHAo=
X-Talos-MUID: 9a23:AbnJ1ga0nnzCWeBTkA7OrRIzEMRTx4uSCBAO0ps4tPLbDHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by alln-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 06:54:09 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
        by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 3886s8Rh027099
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 06:54:09 GMT
X-CSE-ConnectionGUID: EnZWZw96RE2pe8xJ5DjY4Q==
X-CSE-MsgGUID: k9YCd0vtRkyq5qiNM7NKrw==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=deeratho@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,236,1688428800"; 
   d="scan'208";a="645131"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 06:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ/aJd7vnT4OY2/5Lwh84dDPzfVX4a8WfUag56f1MuRkAWBpMbf8PH2L3E47IiJQPQYV1Xynzy3TZhz3TEdWpYBXQhgVlrCCj80mq6x9MoYcsQu8FJm7Pq1avoPARp5ZhI5o/0GFv4RwHHzGqTc5BFK5jd+zcFV9mJJ6T+RWKmtBzPLftEkF7wRgc1YxYmohsXB+aKyoV3P8uigjLqHUAfmhuv6F7gcSuyoi6EOSo5j17eerFTYGyko3JA4WIeMJl4xGo9xU7gvO4SSclo/cME+bN8OovSpDwm2t7XBM2F+yzRCDMZDnt0qZ9KJX7v1pL87rYnUZzgrt62ZLhmzlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTpjVFDJIhZ0PXZwy0GbbXZ2owdqy1b93LfpRJW8HCU=;
 b=If6ShRylyo5TO/mk8RFabRXqbTdxwLdWUBzXDnX/dVycQpXf6rLW8MD+uRBUKonJp/MtoORQHNjWUUvuqZ/lpMisgiaiTMk6Q/dPsWrZrPE+nZIm616h2pbrKXtfPtjhw8+UZL3OZJpCb0Bo+OY6GW3QCCRE6NHC/v/TJgTHA2HAxEfexmWnU2Rkd/+afQ4jXU7uFBUavEzahIpudoXpzssS2Q/8MsO6i2G3ODX84EmBuvGvqK+sSEz52oiCdw+0feJuUjdYghAnscpKjzQo7NI4yf2NRk9BRUiNVtzogfDDVAcbSDXmjRkcMo9tl1PtZ/6wyQapYY9mfJaE2xRJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTpjVFDJIhZ0PXZwy0GbbXZ2owdqy1b93LfpRJW8HCU=;
 b=XySSeDkM4x7ydd7z5VjG9JI2bEFIRklBe0iFTm48NTSuTM72wvASGBIXYqMdNItHFjpLVFuBDH6lPaExUMqihh18XHO7BcwPoc5Ds6ZCrfC3s/TtFETxvo3n0nCM6g44JlevF74ryi/jLAtdL+uRgw1djGlzc/O44FOQ35iGwXU=
Received: from DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) by
 DM4PR11MB7399.namprd11.prod.outlook.com (2603:10b6:8:101::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Fri, 8 Sep 2023 06:54:06 +0000
Received: from DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740]) by DM4PR11MB6189.namprd11.prod.outlook.com
 ([fe80::9b29:81ff:3783:1740%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 06:54:06 +0000
From:   "Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco)" 
        <deeratho@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Topic: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Thread-Index: AQHZ4LvcJrVsnoRBq0W95V9qrz7orbAPJ16AgAEtl9CAAB50cIAADDAAgAAAvOA=
Date:   Fri, 8 Sep 2023 06:54:06 +0000
Message-ID: <DM4PR11MB618943BFA18521150923326BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
References: <20230906121525.3946250-1-deeratho@cisco.com>
 <2023090738-passive-snowless-3b9d@gregkh>
 <DM4PR11MB6189DEDD52F3E17C8C4E3D1BC4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <DM4PR11MB61890EE125816A786D153C22C4EDA@DM4PR11MB6189.namprd11.prod.outlook.com>
 <2023090820-wielder-angled-3def@gregkh>
In-Reply-To: <2023090820-wielder-angled-3def@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6189:EE_|DM4PR11MB7399:EE_
x-ms-office365-filtering-correlation-id: c01ea2ab-3468-497b-1a37-08dbb0386538
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vsmsDWv70d2HFcZBuNuBMjtn1K3vIyZRZaF0gcWX03icq6YuOTA91+bzcH1PWXwOBgq93d0KJ+mWNXdrB+KHGXXsoJNYjEWcL9gcsRwjsqpGjjEVDJW7xhgJAp/BnKdM5VwpBOmxdwSDh8Ev4lOxFNkISJcCB/EPPO9MRfG3BNhRpia2491dWblQRdDCKLDamc9A2+fJXuo0o1Tdo53DTTNp+WL8M4zE2wpVOTmjckqvheKLLnmFBN2X1sCvnl8NcWaIRUpGkgYF6izp2hb3YeKOmsT3hrTdmwiYFf4Udm78i6f+J3j5pVMwQAeEV4SQ7CJIvM0hfKBGHjwb6S8urpSWBpKCq5uonvVon4dwCDdtl83bY6JNt4DA4a4X1MPZvhQPvX/lnt1q4fVSdv2mzMstsBZ/1QtY9wftveNz5ifcttjW4MuYaiojKsdQd22K5W9GDhvtaIxxuHzYB2VKL3IcuEP9tVnFU1OpjUqqx/rQtlY8oA1j9kEmbjBNlqi/zC3/INEsJaFOd9K1EyqIP3aL8Qy7rpiySlsKWBD5eoHhuODezECUojRzE0nO72Sz7I3BSrJjh/iKddrgz76zINHZrn+M8vdJajpm0yyTLu7iMuhA+BmOq3Hz5CIb7ztP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(186009)(1800799009)(451199024)(7696005)(9686003)(71200400001)(6506007)(53546011)(83380400001)(2906002)(478600001)(4744005)(316002)(66476007)(6916009)(66556008)(41300700001)(66946007)(8676002)(54906003)(8936002)(64756008)(4326008)(76116006)(66446008)(122000001)(86362001)(38070700005)(55016003)(33656002)(38100700002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rbmv3XTR4nHJPkZfJ4sPo103hO8y6uMZHKREhYT3q1DB3wK/2UUHcDdj6jc1?=
 =?us-ascii?Q?fNQLxoKlYDQZdURgYZ/+GR12FEyNw7D5mbCP3fcUoWSELib2LXpyfC9R2cOn?=
 =?us-ascii?Q?8C+TQZ1J0T0Mtn2fA7yivtOwc/7Jb/FsG134k4XTO9i9iUbks2a7pFWCvDUn?=
 =?us-ascii?Q?T2WMYfWkOoz37fnL3FzYwaLuJCkZRJFkTNOS6Kak3FHAeIGXuO1jHgYjzSvT?=
 =?us-ascii?Q?oBCGVhOXXH50/KhxKRmYVwsvzVtWek67jx1wLvCUI5RUVwySgOXDp4K2d3sr?=
 =?us-ascii?Q?W9GwGIKFVR3IgL7DpUnftd2gHTEOWMtMOEFFN7OgsfBKxwQ507Vcjk4mAx63?=
 =?us-ascii?Q?1VVnIDyyFrIsojvvnd5Ow90eFAnPVBbHhYsmYZH7w9wRvr2ireShQSVRAInC?=
 =?us-ascii?Q?u2cdWCzEMWB7IPL4hJ0dwIwenC+1Vn7vC94LokQQtvRl/pqYb8WUr/CABnpy?=
 =?us-ascii?Q?tYg8612+QTgX9x2IhGJSmpYRFChg2ehBfb6xDBgo/Fct8U4EuT0iW82aGFGb?=
 =?us-ascii?Q?aLKh76mWFPw0RLnmJ1EeAeuTdkBBT6OEDY1CBH7lLF3WSRztbxv7N0sb0YRs?=
 =?us-ascii?Q?0GyznKVX9OHowTAl5Me0n4SLHSrCADT5vjdoJUm8djZ+Uq3XlEeeB9sQYGyw?=
 =?us-ascii?Q?5MTzQToKtWyOWafZbzE/pbbxRLm4VHpvlJgQsQsbh0gxi7VkU4ur5SAH/cnK?=
 =?us-ascii?Q?zxJwNLs58qKw+b3RZs6tzd3hAWDoj11DLNvVeY8YWwkQ0og3OT9hnYQNq+xo?=
 =?us-ascii?Q?Z5JGMfSQVUitjqEzPw/VRe5LDZ75b4Xf4IHcjKisiwH5y3W9EG+aC6CG1mLm?=
 =?us-ascii?Q?LZPK5pzE+hKQkYfBbjHWVdzVY8D7D0sKuP3E4O+LMsMl53QqVHHK4YovWml2?=
 =?us-ascii?Q?tOOsjE7XrHH2mHXtSCkdBaqZu34wjLDuYa/9OxH9yxqsQCrgfyIshnEA6Hod?=
 =?us-ascii?Q?upsJ63U2n4LrKaqGw4aw/CgcZJNOZSqGbc3fOTCpR1/SKKGNuLBMfY4XDmJB?=
 =?us-ascii?Q?XirTmgbCUNx7IUgVC+cZBRm7PYuBVS78Kilm10y2jtulz0sG1oT/rvX3L2rf?=
 =?us-ascii?Q?Wix3j3k3oYz2mnMKN2madn6C0qEHTp5PNP8q3QTU7e0goTGNDH5410z7A+X5?=
 =?us-ascii?Q?PP35cAWUdVuFuh5LgwdvTbU5tkbHowHmTRBLeLZI1WwbfKsqlgoFwNZHAwsJ?=
 =?us-ascii?Q?08n3CwQR8JylTFSXSce/KrcvtEPFrCuDdSn3A4NZSr+65blJrVF2wJ0FdlRy?=
 =?us-ascii?Q?mYVyNa28pMG4QVOUV89RjfSNuFSf3X0N39hcxaLhUZwEem5Ab68poyYK9iCS?=
 =?us-ascii?Q?XxC8n2gD0PimsNa1QXR7b7BRM7c6zqo/hoiWD0B1QYfQZ2JRvhGT2MKDw4Xx?=
 =?us-ascii?Q?7btpc6dxm3TayV7KcvUxb8Dl4R7RQXW0WmHC4gptEEOCK/Ghgbaq5NcvcgAi?=
 =?us-ascii?Q?9DB07wPhRnjh5eQyt3SI/oC0+1SXcnD3lWEr5y+dsUWFzyV1GuerES3fgUGo?=
 =?us-ascii?Q?ebU3KwcZ22bG0R8Z4+7OO6m6kzGTMzwaMPWMVq6YLuWNtQxipWt+w4UDGA1d?=
 =?us-ascii?Q?zYgQWtAW3UK55GExqhRfnPpEuCWumanJzFoHgavucwkvE5YNF7eJ51WyrKfS?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01ea2ab-3468-497b-1a37-08dbb0386538
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 06:54:06.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7R8q2FB8bpZaL+UtpXWWB2n1DL4wcTOizMB19Vtm3n7fnPIDi2N8EluK5/uW+wCrA7WX8AHX2Y/bZp39yQDIqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7399
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: alln-core-5.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This change is required to fix kernel CVE: CVE-2023-1989 which is reported =
in v6.1 kernel version. It is fixed in upstream starting from v6.3 kernel v=
ersion and required to fix in 6.1 kernel version as well so we have backpor=
ted this from v6.3 kernel version to v6.1 and I have sent this patch for re=
view and merging.

Regards,
Deepak

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Friday, September 8, 2023 12:19 PM
To: Deepak Rathore -X (deeratho - E-INFO CHIPS INC at Cisco) <deeratho@cisc=
o.com>
Cc: stable@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in =
btsdio_remove due to race condition

On Fri, Sep 08, 2023 at 06:06:32AM +0000, Deepak Rathore -X (deeratho - E-I=
NFO CHIPS INC at Cisco) wrote:
> Hi Greg,
>=20
> I just saw that v6.1.52 is merged and released so can we consider this pa=
tch for v6.1.53 for v6.1 kernel.

What patch exactly?

confused,

greg k-h
