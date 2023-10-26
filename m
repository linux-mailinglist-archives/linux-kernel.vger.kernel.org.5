Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259047D8A14
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjJZVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:12:38 -0400
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A862F10E;
        Thu, 26 Oct 2023 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5235; q=dns/txt; s=iport;
  t=1698354755; x=1699564355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=69Xt4piBpBpaZyW4xnBodSO3qA/qFqy/Z3tHwh1EdG4=;
  b=bz5eElRsp4CNPDsZFVWY1T4hiqqMqFcnjz+3oFxOBc9hS4t6Br7/aQwm
   SuiJ+MB+YAXoc4QvvuD0QRCjqmF7kk9z9yrRF31ap3ocsSRAbkaAtbBgk
   hno+Fbz/K9CDCEX9lH3gdvAOxrDl6SOu0xt7Gq/h/mKjtkj5hYSXGtzF/
   8=;
X-CSE-ConnectionGUID: v56xoRxsQDeDB7DAjz8Wyw==
X-CSE-MsgGUID: Dqk3kGZbRR6TSSj0yU78bQ==
X-IPAS-Result: =?us-ascii?q?A0B4AwAn1TplmJhdJa1agQklgSqBZ1J4AlkqEkiIHgOFL?=
 =?us-ascii?q?YZAgiIDkliLJRSBEQNWDwEBAQ0BATETBAEBhQYChxkCJjQJDgECAgIBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBAQEBHhkFDhAnhWgNhk0BAQEDE?=
 =?us-ascii?q?hUZAQE3AQ8CAQgYLjIlAgQOBQgaglwBgl4DAaI7AYFAAoooeIEBM4EBggkBA?=
 =?us-ascii?q?QYEBbJsCYFIiAoBigYnG4FJRIEVgTuBbz6CYQKBRhoHhhoig3WDGoIgBzKBC?=
 =?us-ascii?q?gwJgQODLimBE4sXXiJHcBsDBwOBAxArBwQwGwcGCRYYFSUGUQQtJAkTEj4Eg?=
 =?us-ascii?q?WeBUQqBAz8PDhGCQx8CBzY2GUuCWwkVDDRNdhAqBBQXgRIEah8VHhIlERIXD?=
 =?us-ascii?q?QMIdh0CESM8AwUDBDQKFQ0LIQUUQwNEBkoLAwIaBQMDBIE2BQ0eAhAaBg0nA?=
 =?us-ascii?q?wMZTQIQFAMeHQMDBgMLMQMwgR4MWQNvHzYJPA8MHwI5DSssAisDRB1AA3g9N?=
 =?us-ascii?q?RQbbZ5IgmgHdAcUKQaBViMHLpYoAY1MoS0KhAyMAZUfSQOFQaQjhSqCUpBAq?=
 =?us-ascii?q?CgCBAIEBQIOAQEGgWM6gVtwFYMiCUkZD445g1+GFYlkdjsCBwsBAQMJi0oBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:dTvxZR8B3wwFzv9uWO3oyV9kXcBvk6//MghQ7YIolPcUNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8ERHER98SSDOFNOUN37e0WUp3Sz6TAIHRCqPA90LfnxE5X6hMWs3Of08JrWME1EgTOnauZqJ
 Q6t5UXJ49ALiJFrLLowzBaBrnpTLuJRw24pbV7GlBfn7cD295lmmxk=
IronPort-Data: A9a23:fkE4i6I7dqMpTn+lFE+REZUlxSXFcZb7ZxGr2PjKsXjdYENSgj1Rm
 mpKWTzXafnYZWTxeo10aozl9E8CvZLUyoRgTVQd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcYZsCCea/0/xWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVvW0
 T/Oi5eHYgT8g2Qqajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFbMbpq/AG2ikiOCe42eZX1Lu0aVRHV5jaOX0+s4vaY1P3
 eYTJDZIZReZiqfvhrm6UeJrwM8kKaEHPqtG5Somlm6fXK1gGM2ZK0nJzYcwMDMYj8VPFuvab
 tExYjt0ZxOGaBpKUrsSIMtkzLn11iajL1W0rnq5vKls4EfhxjZLjoTWC9iNa+HVFc9syxPwS
 mXupjSlXU5y2Mak4T6E9G+8w+zChyX2XKoMG7CisP1nmluewioUEhJ+fUGmuuX8hEmkHtZeL
 VEE0jQhoLJ090GxSNT5GRqirxa5UgU0QdFcFagx7xuAj/OS6AeCDW9CRTlEADA7iCMobSJ3i
 E+OpcPyPBBinJfKZVuf5OervCznbED5MlQ+TSMDSAIE5fzqr4cykg/DQ75f/Eid04yd9dbYn
 mDikcQuu1kApZVUiPjjrDgrlxrp98eZFFdkjunCdjv9tlsRWWKzW2C/BbHmARtoNo2VSByKu
 2IJ3pHY5+EVBpbLnyuIKAnsIF1Lz6jeWNE/qQcyd3XEy9hL0yXyFWy3yGouTHqFyu5eJVfUj
 LXvkQ1Q/oRPG3ChcLV6ZYm8Y+xzk/mwToi4DqyON4QRCnSUSONh1H82DaJ39z61+HXAbYlkU
 XtmWZ/2VC1DWfgPIMSeHrpBjtfHORzSNUuKFcykkHxLIJKVZWWeTv8eIUCSY+UihJ5oUy2Lm
 +uzw/Cikk0FOMWnO3G/2ddKcTgicyNhbbio8JM/SwJ2Clc8cEk7FeTryK8sE6Q82fw9ehHgp
 C/tAye1CTPX2BX6FOl9Qik4Nem3AM8v9StT0O5FFQ/A5kXPqL2Htc83X5A2ZrIgsudkyJZJo
 zMtIq1s3twnpuz7xgkg
IronPort-HdrOrdr: A9a23:DvZRJqPypOyKXMBcT73255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UcssREb9expOMG7MArhHQYc2/heAV7QZniXhILOFvAi0WKC+UyuJ8SazJ8+6U
 4OSdkCNDSdNykcsS++2njHLz9C+qjGzEnLv5aj854Fd2gDAM8QinYcNu/YKDwIeOAsP+tAKH
 Po3Ls8m9PWQwVtUi3UPAhiY8Hz4/fwuNbNZxkACxQ76A+Iow+JxdfBeSSw71M1aR8K5a0t31
 TkvmXCi5lLtcvV9jbsk0voq7hGktrozdVOQOaWjNIOFznqggG0IKx8RryrplkO0aOSwWdvtO
 OJjwYrPsx15X+UVHqyuwHR1w7p1ytrw2P+yGWfnWDoraXCNXcH4ot69MZkmynimgwdVeJHof
 t2NqWixsJq5Cb77WPADh7zJkpXfwSP0CAfeKUo/g9iuMMlGc1sRMokjQBo+FNqJlOn1Gjhe9
 MeUf309bJYd0iXYGveuXQqyNuwXm4rFhPDWUQavNeJugIm1kyR4nFojPD3pE1wv64VWt1B/a
 DJI65onLZBQosfar98Hv4IRY+yBnbWSRzBPWqOKRC/fZt3d07lutry+vE49euqcJsHwN87n4
 nASkpRsSo3d1j1AcOD0ZVX+lTGQXm7Xz7q1sZCjqIJ94HUVf7uK2mOWVoum8yvr7EWBdDaQe
 +6PNZMD/rqPQLVaM90Ns3FKu9vwFUlIbooU4wAKiezS+rwW/nXitA=
X-Talos-CUID: =?us-ascii?q?9a23=3AhBpdl2g7ywQq+PBObkKrJZJJ1DJubCCD3HDqM1S?=
 =?us-ascii?q?BJWtFYuK5YF2CqJx1jJ87?=
X-Talos-MUID: 9a23:Jpp+lAvSCJVcUuirIs2nqChhb8RH0a6UMh4xqq4E49i5anx6AmLI
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 21:12:34 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
        by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 39QLCYZq029584
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 21:12:34 GMT
X-CSE-ConnectionGUID: b2fd67loSkG/0JDINXl1DQ==
X-CSE-MsgGUID: jji29DCbRG+dPxrm74AlsQ==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,254,1694736000"; 
   d="scan'208";a="6020714"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 21:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM+TSNQ50zUtPGygUZXe7js7cxAYIg09rFQ2hufXKRz7cFk/verqaGzEbY5YHb5U5oC6FH5pbBTBaRK4jNobwTEVyFNY//JHZrpjlkffx7s8wUe7zgpHShwpsUpkWHgP1P+1xuXtYjK7MAeFOFACMe98VBprqSlh0vLch/W57hBYGdx9gxW1KcUsfzYEyhDuwaTuxJ47dJDn3W0NW+xs3aciLMASNR11QOTZkZ3vdrjY1dbt5wYLRGqmC/um+3/Ty1+qESb3Y/D+hWzlYnoPpMnbvnrm4eKCyM/F6GKC+3XjpMkJkje+xSI+O5yPhfdcxxW2rTI0u1QyvBqorL1Nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urofFeUoSJN8zYlHQlnC6zfTh9VDbHsawjDGfIHRjDk=;
 b=cjR87ibz3izKdBZ7EzNFFANsql+11L6uyaGgSht7YMlhM8Jq+sndq15MU9/fjOkXe9BZK8h/+3VMNJq6ajzt4vVL9IRxtMNTrV9HmmpMz8z+i1uXSdLksd99V0YSTUEXtyOQ/3zKQoRko0nNGBBhZCccI9SBH6Tw1yxG93fu3FE16N25ES0Bbrz3c+MXbs53SQ2ARusZxZUo9ULxrt7guvSVPcoZ7R+w+4jqXQb+mFeDmhcSSXv7cd1N/KNE3ogcOOVOe4/pZWR+Wst3E0cvBADEhB6PkOhistb22kSwBJRE24xf778BgnbuE4L/KBZxwiGo2nhZ6BSPvJhUFjrC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urofFeUoSJN8zYlHQlnC6zfTh9VDbHsawjDGfIHRjDk=;
 b=COssdRnVQJaEzciBwGrBe7sTnFVuccGfITtfIHbjXP6qYZaFcE3bp5JznLfhnecLLmpzLQJkE+VD26C9qxZwW1dSGBhMnpQc2F9epP8GBnmkpEqOsddIUgufZPp8EChhEX02K9WrkdHU0j3G7FNOmPhiKBbs3XAld2MY3Rck0e8=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 21:12:31 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::dbd8:84b0:9c4:d12b]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::dbd8:84b0:9c4:d12b%5]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 21:12:31 +0000
From:   "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To:     Benno Lossin <benno.lossin@proton.me>
CC:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Viktor Garske <viktor@v-gar.de>, Finn Behrens <me@kloenk.dev>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rust: macros: improve `#[vtable]` documentation
Thread-Topic: [PATCH v3] rust: macros: improve `#[vtable]` documentation
Thread-Index: AQHaCFEhkgGvn195Oky/RWgqFr2q2w==
Date:   Thu, 26 Oct 2023 21:12:31 +0000
Message-ID: <au3adook2dsnveqlz3i7inmbzx7b5sel7qg2cn7efcacicthiy@fm5io4kam3s2>
References: <20231026201855.1497680-1-benno.lossin@proton.me>
In-Reply-To: <20231026201855.1497680-1-benno.lossin@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|PH7PR11MB8570:EE_
x-ms-office365-filtering-correlation-id: 66619fc7-a013-498d-49ea-08dbd668445e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E/hTSLUis3bTE7ACmnTMTZaRmdPUCFsYE10/DveKmP9eTQisPbSUkOEdU0tr8KFCmiUiwqT8qFVRdyekmlkiIcmFZmLb4cJyg/FuNCGHfpwjF62wJBhgQ6foONymYfQeNvwFiiil1rGSlfMVkp8MOrDoVQZmPhTiW0CkoWArWjXTs1VyYQ74Z3WxzS8JBhDc/CFFKlHTRsHf13SmJ/c4IbA6cHntSmcEvEFavGFM4NbqH2GKx3xLw+jMl/9jWY0zjZhU9d0cbSPPhtiYbpDHn6Aq8iMQOF7hqpwZGIchMHKY6WIotifkdPoiaA4IazqoNNlTDGPLL7NUtqWu6HzxlLB9PJGQcqtX/siFKKELT2sG5anc+BO/GSc1qHLq1DYJcBGpM3St1opCS7blxtm9CIp7ZdHlybBQQ1z6T7vgjp26ACg1vrcsjVKZs4kXwIKff5Z6TTqb0wFUrjX97VuCSBHz0ClSt+RaZ6EC894JITZh48IH7fTAwVNAfCYx9Zm2NLKrH3yVm9RXe/K5zrDnGu8k9RNqr5p7NCHCms5kYZ7yUjg/mw2t8kq2pQ6z519GqhZG5QMzijotEO993mrtXgl1Atz5xqW2ZrPsrddMdSltpDOMGBmgBOEERJjZFrWM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(478600001)(66446008)(316002)(66476007)(6916009)(91956017)(66556008)(76116006)(66946007)(4326008)(8936002)(8676002)(38070700009)(54906003)(64756008)(6486002)(5660300002)(71200400001)(6506007)(33716001)(6512007)(38100700002)(9686003)(86362001)(2906002)(122000001)(83380400001)(26005)(41300700001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A6rcaCjS8KSbIgjMwd43DGgC5sPSq9tDoYp5qkQKicbOShmFPBUmngsMwS?=
 =?iso-8859-1?Q?fEtDc8Au3pJ3MW46/fga0Iy0W5TPSCEqPoMxrOoktlvTDMLL8yY+whyOm2?=
 =?iso-8859-1?Q?FpcFLpX7XengtL11X5bNmib1VLWsVu+QCjz14xJNPRJcR8p/fUF3otgenp?=
 =?iso-8859-1?Q?6b/KeT/f0nu8TNRtm0G3t/LoAwZCWFCrd1RjKhH4v7AvYJTBEryqgP/oSb?=
 =?iso-8859-1?Q?Pvyy1qBpjeetZcOOKcYMh8ZeUxpsxfpkMQjJ256NrB35b1h6+q87C7wmKa?=
 =?iso-8859-1?Q?Zb5tpPvIXv/XWd0WbdBV0oYwUNFidu6hc3gHdSFK65A1AIClFsAIMBYbCr?=
 =?iso-8859-1?Q?Gw0fCgk5nI8RjL/IRDlgezBRXzkzmGhTZF7Wf1x8Yqm/fMons+4TEkGDos?=
 =?iso-8859-1?Q?2y6dKWZp9AnwLBNuNPpMoF4NlvmFpPLzA8QBR/gsxrxqQ2XkqRrcLe9h+C?=
 =?iso-8859-1?Q?UKZEeqOSsHlk2gdMqNj/ZnfxTFkMgX/nMp6GByx8IPkQkXzYKwNr7g5Y3T?=
 =?iso-8859-1?Q?vDp+bxCclsoxoLrXdO6istA5tjzpnnyjZuy9pmzqvCZrYUyCxalvcykqQA?=
 =?iso-8859-1?Q?i2OQY87vFGJWUpluqYzode02nhHuLFX/gq7Fq2jqDTQqO6GG1NPGA+X0do?=
 =?iso-8859-1?Q?1VfAaNwv34FlizosX6S678pf7dB+d0LPdMBRJB82FM+X7POhzpI3kU1PnS?=
 =?iso-8859-1?Q?TXmU3PuyCVVhel3B5RLuE4p4Zx6JhSjdenJQM5SfOB8zXfWI6HM2LZpvmJ?=
 =?iso-8859-1?Q?kDYJi+CkRheveRonTaAZwddfX91eON8pRTlx2x3jwPUb8WoTCjh7+uVQ6W?=
 =?iso-8859-1?Q?SZ0dQJ8dv4+LmW3W7E9s/rrJXnLJ29Bfi3iGlVxFPcWvadoquY59x+bhvd?=
 =?iso-8859-1?Q?M5C6S+4RggrorU62s/uYdC52gR25C7Oan7EFenyz2PyAExLd7BtBIVAAxq?=
 =?iso-8859-1?Q?7uy55FnPzNE53CJiiRLN6hnxQaZtPVNHOzE3ouSPD4EjPV0UvTiKUHfKwg?=
 =?iso-8859-1?Q?zRvLmpgqpc65MZw7SV7CS/DeAal9oN1B63XIXABBEYNrcg5VzZVsosdEHG?=
 =?iso-8859-1?Q?TMg1IDrbCsyCndevzE48GQqyqXXqwM0Q1XEI7GyCSxlGMWJ/omqOOfWhYM?=
 =?iso-8859-1?Q?iRTWN8yTSTJwtYKqxCAyTdGNWK20xpiKRhnC8eIio/Nhsvvg/cdmF5YvLR?=
 =?iso-8859-1?Q?oglQm9SkJlVh7zcr7LVpGRpu7ynjJT/5o+dnTl0gSqLsi/tAXSMKIV8Dsg?=
 =?iso-8859-1?Q?JZqI189SbaG4eitBDlRh6b+A9/cEEcTiuVR3/iF1iE5PBp62CIu2SL6sAG?=
 =?iso-8859-1?Q?9Ch0VacTpq6LKKsLAmqC6WIsrTyC2du85rASp5OAVC4TpLGL2ydu1Xd5+y?=
 =?iso-8859-1?Q?N6pW5HkVy3dkXGUmo5zdts3xhzgUrQHgVCutAUT/EKZGP7fuBqz1aXzhzb?=
 =?iso-8859-1?Q?ijIxkzuSKY5oY0fIN20jkvBMLdkAd1B3rOCsCknKdRbHdLqljRZ4r8HFri?=
 =?iso-8859-1?Q?Gg9Es5qTdAiKpbJY3TdK4mM8h6rNiXteQXR7N0STWZZ4dJGc7fQqJXkTUf?=
 =?iso-8859-1?Q?w9ZwsU7O6kLhQhszOybJn7VuirArV2arKA3WaoGkQJg6NVqizvMNucEvAU?=
 =?iso-8859-1?Q?Crkj+PBf6AbpR0WAc3/WA15z5ZcHak+97g?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8A3B865F8AF182489BEF36E4E9DB8169@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66619fc7-a013-498d-49ea-08dbd668445e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 21:12:31.4597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vP341gkhtftpGM9giTZCN6N8vSAXi1LOfJ+vG+F45w3gn9MBe6Juzejby7pokvhKkx9Nxs5l1lJqOcuB5CHBuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/26 08:19PM, Benno Lossin wrote:
> Traits marked with `#[vtable]` need to provide default implementations
> for optional functions. The C side represents these with `NULL` in the
> vtable, so the default functions are never actually called. We do not
> want to replicate the default behavior from C in Rust, because that is
> not maintainable. Therefore we should use `build_error` in those default
> implementations. The error message for that is provided at
> `kernel::error::VTABLE_DEFAULT_ERROR`.
>=20
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> v2 -> v3:
> - don't hide the import of the constant in the example
> - fixed "function" typo
> - improve paragraph about optional functions
> - do not remove the `Send + Sync + Sized` bounds on the example
>=20
> v1 -> v2:
> - removed imperative mode in the paragraph describing optional
>   functions.
>=20
>  rust/kernel/error.rs |  4 ++++
>  rust/macros/lib.rs   | 37 ++++++++++++++++++++++++++++++-------
>  2 files changed, 34 insertions(+), 7 deletions(-)
>=20
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05fcab6abfe6..1373cde025ef 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -335,3 +335,7 @@ pub(crate) fn from_result<T, F>(f: F) -> T
>          Err(e) =3D> T::from(e.to_errno() as i16),
>      }
>  }
> +
> +/// Error message for calling a default function of a [`#[vtable]`](macr=
os::vtable) trait.
> +pub const VTABLE_DEFAULT_ERROR: &str =3D
> +    "This function must not be called, see the #[vtable] documentation."=
;
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index c42105c2ff96..917a51183c23 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -87,27 +87,48 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// implementation could just return `Error::EINVAL`); Linux typically u=
se C
>  /// `NULL` pointers to represent these functions.
>  ///
> -/// This attribute is intended to close the gap. Traits can be declared =
and
> -/// implemented with the `#[vtable]` attribute, and a `HAS_*` associated=
 constant
> -/// will be generated for each method in the trait, indicating if the im=
plementor
> -/// has overridden a method.
> +/// This attribute closes that gap. A trait can be annotated with the `#=
[vtable]` attribute.
> +/// Implementers of the trait will then also have to annotate the trait =
with `#[vtable]`. This
> +/// attribute generates a `HAS_*` associated constant bool for each meth=
od in the trait that is set
> +/// to true if the implementer has overridden the associated method.

The above paragraph seems to be wrapped at 100 characters while the
paragraph below seems to be wrapped at 80 characters.

Cheers,
Ariel
> +///
> +/// For a trait method to be optional, it must have a default implementa=
tion.
> /// This is also the case for traits annotated with `#[vtable]`, but in t=
his
> +/// case the default implementation will never be executed. The reason f=
or this
> +/// is that the functions will be called through function pointers insta=
lled in
> +/// C side vtables. When an optional method is not implemented on a `#[v=
table]`
> +/// trait, a NULL entry is installed in the vtable. Thus the default
> +/// implementation is never called. Since these traits are not designed =
to be
> +/// used on the Rust side, it should not be possible to call the default
> +/// implementation. This is done to ensure that we call the vtable metho=
ds
> +/// through the C vtable, and not through the Rust vtable. Therefore, th=
e
> +/// default implementation should call `kernel::build_error`, which prev=
ents
> +/// calls to this function at compile time:
> +///
> +/// ```compile_fail
> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
> +/// kernel::build_error(VTABLE_DEFAULT_ERROR)
> +/// ```
> +///
> +/// note that you might need to import [`kernel::error::VTABLE_DEFAULT_E=
RROR`].
>  ///
> -/// This attribute is not needed if all methods are required.
> +/// This macro should not be used when all functions are required.
>  ///
>  /// # Examples
>  ///
>  /// ```ignore
> +/// use kernel::error::VTABLE_DEFAULT_ERROR;
>  /// use kernel::prelude::*;
>  ///
>  /// // Declares a `#[vtable]` trait
>  /// #[vtable]
>  /// pub trait Operations: Send + Sync + Sized {
>  ///     fn foo(&self) -> Result<()> {
> -///         Err(EINVAL)
> +///         kernel::build_error(VTABLE_DEFAULT_ERROR)
>  ///     }
>  ///
>  ///     fn bar(&self) -> Result<()> {
> -///         Err(EINVAL)
> +///         kernel::build_error(VTABLE_DEFAULT_ERROR)
>  ///     }
>  /// }
>  ///
> @@ -125,6 +146,8 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// assert_eq!(<Foo as Operations>::HAS_FOO, true);
>  /// assert_eq!(<Foo as Operations>::HAS_BAR, false);
>  /// ```
> +///
> +/// [`kernel::error::VTABLE_DEFAULT_ERROR`]: ../kernel/error/constant.VT=
ABLE_DEFAULT_ERROR.html
>  #[proc_macro_attribute]
>  pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
>      vtable::vtable(attr, ts)
>=20
> base-commit: 3857af38e57a80b15b994e19d1f4301cac796481
> --=20
> 2.41.0
>=20
> =
