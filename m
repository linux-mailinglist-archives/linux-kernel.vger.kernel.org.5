Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A614D7D7193
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjJYQSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjJYQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:18:45 -0400
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC028137;
        Wed, 25 Oct 2023 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1216; q=dns/txt; s=iport;
  t=1698250723; x=1699460323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=72O1JVfrMZfSzETYO7dQDjQyEGNZizdfWFRas7lRlEc=;
  b=kQBBePWp5ILB/clTMg6Tb6BR5moWy3xfsnfouGXJkRv6aIyhmLvziJUK
   YB3zfVdnP4Z44nVen2YQWWiA4VcktLwtWm1qlulWBoTLPljl/c5V1hW0l
   h+4mh7J5XlCxrZ5no9CxCqUy9UWK5rByd5yeb1epdq5ZluD2NTBuZtxvZ
   A=;
X-CSE-ConnectionGUID: AkB173jmT1OtEIHhfiGObw==
X-CSE-MsgGUID: oQYH0Hm8RauRh/cM65G5hA==
X-IPAS-Result: =?us-ascii?q?A0BVAABjPjllmI0NJK1aHQEBAQEJARIBBQUBQCWBGAYBC?=
 =?us-ascii?q?wGBZlJ4WzxIhFKDTAOFLYZAgiWSWIslgSUDVg8BAQENAQFEBAEBhQYCFocCA?=
 =?us-ascii?q?iY2Bw4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZB?=
 =?us-ascii?q?Q4QJ4VoDYZNAQEBAxIREQwBATcBDwIBCBgCAiYCAgIwFRACBA4FCBqCXIJfA?=
 =?us-ascii?q?wGnewGBQAKKKHqBMoEBggkBAQYEBbJsCYEaLgGICQGBUIg2JxuBSUSEPz6CY?=
 =?us-ascii?q?QKBYBeDRIJog3WCLYMPBzKBSVmDLymEAogOCVUjR3AbAwcDgQMQKwcELRsHB?=
 =?us-ascii?q?gkWGBUlBlEELSQJExI+BIFngVEKgQM/Dw4RgkIrNjYZS4JbCRUMNU12ECoEF?=
 =?us-ascii?q?BeBEQRqHxUeEiUREhcNAwh2HQIRIzwDBQMENAoVDQshBRRDA0QGSgsDAhoFA?=
 =?us-ascii?q?wMEgTYFDR4CEBoGDScDAxlNAhAUAx4dAwMGAwsxAzCBHgxZA2wfNgk8CwQMH?=
 =?us-ascii?q?wI5DSsnA0QdQAN4PTUUG0Qpni+EBHo7dHWSMYMvAUmuMAqEDKEgSQOpZJg8o?=
 =?us-ascii?q?w2FGwIEAgQFAg4BAQaBagkqO4EgcBUagwhSGQ+OIBmDX495djsCBwEKAQEDC?=
 =?us-ascii?q?YtKAQE?=
IronPort-PHdr: A9a23:PBHoNhUrkgfgAjZO6f1W2Lu42bbV8K0yAWYlg6HPw5pUeailupP6M
 1OaubNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2s2y1uuv/5TISw5JnzG6J7h1K
 Ub+oQDYrMJDmYJ5Me5x0k7Qv3JScuJKxGVlbV6ShEP64cG9vdZvpi9RoPkmscVHVM3H
IronPort-Data: A9a23:MKrLaaKS3FoM484gFE+RBZUlxSXFcZb7ZxGr2PjKsXjdYENS1j0Am
 mUdCGiGbPvbZ2Xwc41zaYq2p0ICsceGmtBrSAMd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcYZsCCea/0/xWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVvW0
 T/Oi5eHYgT8g2Qpajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFYRF0uaYenq6jZW002DnU3viwtpJBl5jaOX0+s4vaY1P3
 fUcLDZIZReZiqfmhrm6UeJrwM8kKaEHPqtG5Somlm+fVK1gGMyaK0nJzYcwMDMYj8VPFuvab
 tExYjt0ZxOGaBpKUrsSIMtkzLr43yijK1W0rnqSnJsXu0jWnDZ4zYLtd9HwJIGlGMV8yxPwS
 mXupjSlXU5y2Mak4SCY6W7piOjV2Cf6Xp8CPKO3++Qsg1CJwGEXThoMWjOTpfi/l177WN9FL
 UEQ0jQhoLJ090GxSNT5GRqirxa5UgU0Ut5UFagx7xuAj/qS6AeCDW9CRTlEADA7iCMobRUp/
 AbWxNHsOWVIrJC0aXKT95izpyznbED5MlQ+TSMDSAIE5fzqr4cykg/DQ75f/Eid04yd9dbYn
 m/ikcQuu1kApZVQjvnmpDgrlxrp98eREF9kjunCdj/9hj6VcrJJcGBBBbLzwftGMIGfJrVql
 CdawZHGhAzi4G3kqcBgaOwJGLfs7PGfPXiMx1VuBJImsT+q/hZPnLy8AhkgeC+F0e5dJFcFh
 XM/XysNv/e/21P2NMdKj3qZUZhC8EQZPY2NugroRtRPeINtUwSM4TtjY0Wdt0i0zhl8yP5lY
 8vHIZb2ZZr/NUiB5GTvLwv6+eJ6rh3SOUuILXwG5039iOHHNCL9pUktaQfXMIjVE59oUC2Mo
 4oAaKNmOj1UUfb1ZWHM4JUPIFURRUXX9riow/G7gtWre1I8cEl4Uqe56ep4J+RNwf8P/s+Wp
 S7VZ6Ot4Ael7ZExAV/UOikLhXKGdcsXkE/XygRzbQ/2hiJyP9fHAWV2X8JfQITLPddLlJZcZ
 /IEYM6HRP9IT1z6F/41NvERcKQKmMyXuD+z
IronPort-HdrOrdr: A9a23:FcwtLaC4Lu0NT4blHejQsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskdhZJhBo7y90KnpewKkyXbsibNhc4tKLzOWyFdAS7sSrLcKogeQVBEWk9Qtt5
 uIHJIOdeEYYWIK6voSpTPIberIo+P3sJxA592us0uFJDsCA8oPnmIJbjpzUHcGOzWubqBJbK
 Z0k/A33QZIDk5nFfhTaEN1OdTrlpngrr6jSxgAABIs9QmJih2VyJOSKXKl9yZbeQlihZM5/0
 b4syGR3MieWveApSP05iv21dB7idHhwtxMCIinkc4OMAjhjQ6uecBIR6CClCpdmpDs1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6jh2f5q8CRfkN+NyMBv/McTvLq0TtngDhO6t
 MT44tfjesOMfr0plW72zEPbWAwqqP7mwt5rQdZtQ0tbWJXUs4ikWVYxjIXLH/FdxiKtLzO14
 JVfZzhzecTflWAY3/DuG5zhNSqQ3QoBx+DBlMPo8qPzlFt7TpEJmYjtYQid007hdkAYogB4/
 6BPrVjlblIQMNTZaVhBP0ZSc/yDmDWWxrDPG+bPFyiTcg8Sj7wgo+y5K9w6PCheZQOwpd3kJ
 PdUElAvWp3f071E8WB0JBC7xiISmSgWjbmzN1Y+vFCy/DBbauuNTfGREElksOmrflaCsrHW+
 yrMJYTGPPnJXuGI/cB4+Q/YeglFZAzarxjhj9gYSP6niviEPyfitDm
X-Talos-CUID: =?us-ascii?q?9a23=3AeGmj42p/8Wpg9DlgrxqVjJjmUekmWCSCl3XVHxa?=
 =?us-ascii?q?fFUtIaL2bSHC38rwxxg=3D=3D?=
X-Talos-MUID: 9a23:u0YjEQY/uxX/BuBTsAbdpGlCMZdS6rmUCAcGtMtblJSEHHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 16:18:41 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 39PGIfXk014147
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 16:18:41 GMT
X-CSE-ConnectionGUID: 1Bi7zO/TTX6hKhEMmGYV8A==
X-CSE-MsgGUID: gJ9wIajtQ22HAM8mYZQTGA==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,250,1694736000"; 
   d="scan'208";a="5699731"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 16:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIUjSERK/o4rGmaAt5GTQm1LffeXRcma5Ge+BFErNHD1lgQ5MUQ6JBFMgUUFVrcW+0Rv2acNNyLQbiUBFP+wuBdqEHiJIDN7ZU48e63fyP7EiWP2oBGLByfwo2tku37zFU8Yh3eoppvUzIK/InqiurbsoGjVoaK+vXeN7Q5BSBeJgOmp/xm8md+jwHFokaRrqIxLGofv6FJblrE2YFcIWKeCCZGNCjqRsIKiLlyS+7dPzZ6sMI6D6Yc2b+ieWejnFGCnB661weHxSKqKFG1hCkzd/6h889xHTpUz1D11APYfTk3ZFi3YhGyIMxaQwZfZ9WBlL3i67YZUJKUyvdIFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72O1JVfrMZfSzETYO7dQDjQyEGNZizdfWFRas7lRlEc=;
 b=BOTUxxtIsicsgTlOK2X3SRkEXu2LlAhXFMLiWXC79Rn0pKdu4KTDdBJAzOEjv7qOxGjKEruDHpWtKWc4PvQoIc7GKBtzRGMByo27SIFd89NE7Uy4i2AsCsaKvwwqnMLhM8j3YI2uNUqkkZ/9tdfY5bYliI6gY9DN905Zoq/gqwEV3HCVlQdlYc8d+VTuQIVgk8Tyx5q3VBbraq2+ieMuQa9DhIJ2xFgB1fNi7WdjrECVLr+8Hv+z4Tgv0VIe5YMlrqZX7EatPfGjOAUeMqsYhyHslHuBvlq3TcpOPfEDpXtINGih6cpQiB35NURZ3++tE3vH5Oly+VV+z8b5nqxWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72O1JVfrMZfSzETYO7dQDjQyEGNZizdfWFRas7lRlEc=;
 b=oFUDbj2112v+w1FqxlqafZ7TKQTYEqwwnNVJE+Q87ITdkPFwc/d6KxC0hKcDFqJH9a22XTq1SjV0eoq5R4DSswIKPmWzTdzP289mHy616vi+CCjRg2GgVpi2WGIMDcptUcTbSUmGdYNlxoM6foLz45H7cZO2oo24cpqxLC1siII=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 16:18:38 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::dbd8:84b0:9c4:d12b]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::dbd8:84b0:9c4:d12b%5]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 16:18:38 +0000
From:   "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     Alice Ryhl <aliceryhl@google.com>,
        "ariel.miculas@gmail.com" <ariel.miculas@gmail.com>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "benno.lossin@proton.me" <benno.lossin@proton.me>,
        "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "lina@asahilina.net" <lina@asahilina.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "wedsonaf@gmail.com" <wedsonaf@gmail.com>
Subject: Re: [PATCH] rust: kernel: str: Implement Debug for CString
Thread-Topic: [PATCH] rust: kernel: str: Implement Debug for CString
Thread-Index: AQHaB17pyf2qEV03vUqsAMeJkagKAw==
Date:   Wed, 25 Oct 2023 16:18:38 +0000
Message-ID: <hwqyfgbzbnquby5v6zby4u4pbyezzcsttt4ee5x7lw5etpv7se@kvarclpucc7w>
References: <CAPDJoNv1HW-5uCj21PX3t23rJ+sbTL4Gm5pDis8HGJ-VTr4dug@mail.gmail.com>
 <20230714140201.383439-1-aliceryhl@google.com>
 <CANiq72n8-b992D4RbwUtuEUxXfJYQLNwfibgWSyspx-HYJ8+8A@mail.gmail.com>
In-Reply-To: <CANiq72n8-b992D4RbwUtuEUxXfJYQLNwfibgWSyspx-HYJ8+8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|PH0PR11MB4998:EE_
x-ms-office365-filtering-correlation-id: 1b5c99b9-3cf3-416b-c916-08dbd5760be8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Y8oRzrfyfrWKjgG/k790K+d1OHnayrl3u1c857ijn1ezpHdD9bP7w6vrmqIns4x9bzLgiDln08qBqKg3H7fHNMEnd7J1hObQI/5fA3mSaCZO42xj4JgZFAPvZ4mKdtIbGpQNLVjKSYQmVQk9ZffuDnHbwb+2JpfoEOt/QZV1LB6GgWFH2qGLPhW1NIJU2+AbK5G4mmWlCnVlmXkzgmdfnQgRSUb7yYyWJh3oBBg7Rs7/ZR4hQAvrpOpMK9GFJthTUPaCjuBymE3nkFS2Ph+viNiZ3Cqq6irtHBucnBE54NBmqsYVzH1TW9i7pA1QC/NsQa1eSXe59FNvXNTYZ3jFVr35WEH/wHaoeuCbaXols3LacrycnwH6WhUoYwjI9D1JgdTfghhXFTO4O3VasMsabl9sWO9viPunGTUt2ag6LXJ2x0TlK+Hx7upq54pRx+9tLwtNnwT40eAhQpGAKBOrqsrlZl6e/rUHp1YQ8QG3ueLp1BNZor7DJvJyG0VxuJ2XfVFid6ngcmtwIxUGZaJpzZv58mZV1LQOG5EjsJNWAcZgBnz84wcOxpg5FVyOT330sxIhMs+Uu8u41lVDGx8sf5zujL9XUpV5GqjdYol0zvMenFRPTAwXHICK69jmnbQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(396003)(376002)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(64756008)(9686003)(316002)(66446008)(66946007)(66476007)(54906003)(76116006)(66556008)(6916009)(91956017)(26005)(6506007)(53546011)(6512007)(38070700009)(71200400001)(478600001)(4744005)(8936002)(5660300002)(8676002)(7416002)(4326008)(38100700002)(41300700001)(86362001)(2906002)(33716001)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFc3K2JiZnMwUlpacTNYQkpYMDBYd3BGZFJsR1pHMmNhTmIwM21vN2hncENI?=
 =?utf-8?B?VWRiTzBlZ1NGdnNJQVpCRlV4L21NVkpXa2tlT2tZQWI5dHM3WVdhUU1haXU0?=
 =?utf-8?B?bXFSZE5YVDB3QmZQeVpuT0VTcThqNVhFOGEzSSt6cDFWMW1xMWtzK0N3cy9u?=
 =?utf-8?B?QTNZM09pc0JYaXcrQkk3M01odElnMVdtZEROOURkY2JScXZMNVZLaVFSdjF4?=
 =?utf-8?B?Y3lrUkd4K3BkRkVzT2ZtS1ZxcDVpMm1FTDRPeDZTNy9OV29CeEhVQlZOdVg5?=
 =?utf-8?B?ZXA1UVVjMGtkQXM5Sk5nb2h2UVJuSEZEVStGTjJ6Zk43MjdONkhQRi9XbnpF?=
 =?utf-8?B?MW54VmEvbEFLWXFObkhsdHY0TlZoM094aHhaeGtoR3E3WDRNWlJzbUhES2dS?=
 =?utf-8?B?YVh6K3Z6dCttb09iWG1WYzNwVHl3cDlZaE1FYUhvVDJtN2tLK1VUY1hXME5t?=
 =?utf-8?B?TFRDMXdESEpaOVR1V0dIZFV5UjhXYlZIWGtHTDZscWYwMXhsK09oVStJc2Nw?=
 =?utf-8?B?SitEZ2drVS9xRCtiNFVBNGY0eHpqelVFbU84cUw3bUM0UjRXa00zUUZEY0Iy?=
 =?utf-8?B?M2t1RVE4WWVoSHZrbkJHWkNzRHJoQmx0djFqZzZSNWJseTR2RDJ6UTlMVE1v?=
 =?utf-8?B?NkFIdnByK3dsaUNiVXRhdHMyTTlydXFzM0dKOTlQbnNZT2REVVU2a0YzYTJ6?=
 =?utf-8?B?N3lGN2M3cWQ2M3l6cDFwTC9OaFdwbCtjbGpiaUpGQ2FHZXRSdFZNd0NaVkJj?=
 =?utf-8?B?NURJL0FJcXBkbzQ1dWJidEpqeEpEUkZ0YVNnL0FueTlRN0lvQkVmNXRiN2hw?=
 =?utf-8?B?SmZPZzFvKzR0TzRhVGVlK29ZcDVmbDAxM0JKZVg1eC8xRHNpRmpJS2JCaXVF?=
 =?utf-8?B?ZnRQN1R0bkN5eFpCMk0zbXNycmZnMitKczdGVFJjWGwraTd1Rk1QNWl1Rld6?=
 =?utf-8?B?TEM3eUhKa3pMb1lnaVU4eXVyb2t0TmJsSTMzUlhlUjNmd3BBTTdEQVpVWSt1?=
 =?utf-8?B?bnMyZ3dNQVplN3NEUHM4VEVUZVpYTkVBaE5pRDdWOUU1VExNUXhZZmptT1Rl?=
 =?utf-8?B?M3NsNkhmWWhZaTJTR0lyT2xiWkV2K2NlS1hHaDBrU1ZLTUJhUThWUDVzMFJR?=
 =?utf-8?B?L0tHNHlaU1NjajZsb2gyd1J1UytDdENhd2VVbWR5Y0hCY1g5cnhKMVMyNTBV?=
 =?utf-8?B?aU10Q3NKU3g4Z1hyL2gwWVAwZGt2R243dWEyUGVacjN5Y1pUVFZmZk5ESUFN?=
 =?utf-8?B?bUlqOWNWNTJ6ZlFFem5kTm45TmJyanpPcWJuZXV3R1lKcXdZb1ZqMDNONzJw?=
 =?utf-8?B?d0M5bVNJWmFpOXYrRnY0Nk0yR2I2VTNjeGJ4cmk4RlprT1RJR2JjZGNETHZq?=
 =?utf-8?B?K1pmTUU5UFZBNnNkaXlhMnVnMktoK0pTekR1WVVlSDNZdE1BamxqK3RNZEV3?=
 =?utf-8?B?QlRjSmxlSUtCQWVNbHZuTjdCakdCS1BDelYxRkZWeUZSWis5UFpGNWY5Z3o5?=
 =?utf-8?B?Y3pTeTdiY0J0M0treitVM2gxNDg1M08vVEJ1QjRiVXNaK2tFMXVJTVRVRkx4?=
 =?utf-8?B?VGRqeEMwZmUxM3RNK243ckZkQkJrb0dtUjRlQXh5WktweXJyVEdVMVlaQis3?=
 =?utf-8?B?dnVZclBmSzVxL2pTUDlGelp1MTVEcVgwZHFQeEx6TWllVTkwV1VZR0tHMzBT?=
 =?utf-8?B?aFNURzhvYnRZOW1GeEFtMEp2OTNjWjVwWFdVRlhYRG5CeU41WExOSWo0amhU?=
 =?utf-8?B?MVV1V2hKNERvekpjTXV3d0ZGTUczcVlnYVN4QmxwRnNmaXBEVEp1WHVtU24r?=
 =?utf-8?B?K20rNU10d1JHcnV0RHlMU1RCK0VPM3ZmRTlEcnZFdHR2R1M0MDB3OVE1TGo4?=
 =?utf-8?B?ZUdpZFJ0UVlJTFlxc2xnLy90RUJpVXRqdXhxa1BUYkI4WEFnWW01RTFEN0Vj?=
 =?utf-8?B?eHhSeVhnTmpCL2xtM0tVT2JDa3d5TDQ3NXFMcXZrSVhtdWdDVHVHQ096Zmln?=
 =?utf-8?B?Wm10ajhZRWZjQmJ4UTNmRWlWSkt2aXdyVW52UmFCbFR5djQ4M2tNb3lMeVVo?=
 =?utf-8?B?Yi9zTm5LK09FdzJodm5IVE9PQVk2Mys5L3VORHFvKzYvRjd5b0h3cURQT20w?=
 =?utf-8?Q?CxJq2Ad/c5t1dLXmNWWrXW9nj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <722F02AB8C72004CA6E72E5D6BB2C2D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5c99b9-3cf3-416b-c916-08dbd5760be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 16:18:38.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aRi3OJIv+/ag/xNv2aZwDb9L5UcdG5XuliWzfzMh5MaD/Kj/IL8QqzmLONMaLXK6Dtvl5jP8ymZE4B4eMtn5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: alln-core-8.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMvMDcvMTQgMDU6MDFQTSwgTWlndWVsIE9qZWRhIHdyb3RlOg0KPiBPbiBGcmksIEp1bCAx
NCwgMjAyMyBhdCA0OjAy4oCvUE0gQWxpY2UgUnlobCA8YWxpY2VyeWhsQGdvb2dsZS5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gQWRkaW5nIHNvbWUgc29ydCBvZiBtb3RpdmF0aW9uIHVzdWFsbHkgd29y
a3MgcXVpdGUgd2VsbCwgZS5nLjoNCj4gPg0KPiA+IE1ha2UgaXQgcG9zc2libGUgdG8gdXNlIGEg
Q1N0cmluZyB3aXRoIHRoZSBgcHJfKmAgbWFjcm9zIGRpcmVjdGx5LCB0aGF0DQo+ID4gaXMsIGlu
c3RlYWQgb2YNCj4gPg0KPiA+ICAgICAgICAgcHJfZGVidWchKCJ0cnlpbmcgdG8gb3BlbiB7Oj99
XG4iLCAmKmZpbGVuYW1lKTsNCj4gPg0KPiA+IHdlIGNhbiBub3cgd3JpdGUNCj4gPg0KPiA+ICAg
ICAgICAgcHJfZGVidWchKCJ0cnlpbmcgdG8gb3BlbiB7Oj99XG4iLCBmaWxlbmFtZSk7DQo+IA0K
PiBJbmRlZWQsIHRoaXMgd291bGQgYmUgdGhlIG1vc3QgaW1wb3J0YW50IGJpdCwgaS5lLiBhbnN3
ZXJpbmcgdGhlICJ3aHk/Ii4NCj4gDQo+IFRoZSAid2hhdD8iIGFuZCB0aGUgImhvdz8iIGFyZSBw
cmV0dHkgbXVjaCBleHBsYWluZWQgYnkgdGhlIHRpdGxlLCBidXQNCj4gaXQgaXMgYWxzbyBmaW5l
IGdpdmluZyBtb3JlIGRldGFpbHMgKGJ1dCBpZiB0aGUgaW1wbGVtZW50YXRpb24NCj4gcmVxdWly
ZXMgYW4gZXhwbGFuYXRpb24sIHRoZW4gaXQgaXMgdXN1YWxseSBiZXN0IHRvIHdyaXRlIGFuIGFj
dHVhbA0KPiBzb3VyY2UgY29kZSBjb21tZW50IGluc3RlYWQpLg0KPiANCj4gQ2hlZXJzLA0KPiBN
aWd1ZWwNCg0KQW55IGZvbGxvdy11cCBvbiB0aGlzPyBJdCBzdXJlIHdvdWxkIG1ha2UgbXkgbG9n
Z2luZyBjbGVhbmVyLg0KDQpDaGVlcnMsDQpBcmllbA==
