Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB597D0213
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbjJSSu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjJSSuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:50:24 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 11:50:22 PDT
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D3012D;
        Thu, 19 Oct 2023 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4521; q=dns/txt; s=iport;
  t=1697741422; x=1698951022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D/+/E60lqZfmaMHsilGLJXhgkmxQybBsA0YLBdnKWWA=;
  b=m2wJ+3MKPpr0hr9Q9F5PZPgUlhnXN2lso9f9Txmi1qKLJleuMXDE+Bve
   nhEQrsGRdS0JJlpA9RlbOyf7UdgZXUXfC2oDPi7ef/C8h7eKyJHQhJ5e8
   aUs0ZEU4YEKZTtaSb9n5QIXEgJIUFsAgaC82BbN2oq1/e2CV6d9XQLEY1
   I=;
X-CSE-ConnectionGUID: CeXPj8MqQbabxxBg1Io/mw==
X-CSE-MsgGUID: nEGa3RdgT2aS0E/BfGGIcw==
X-IPAS-Result: =?us-ascii?q?A0DNAgDKeTFlmIgNJK1agQklgSqBZ1J4AlkqEkiIHgOFL?=
 =?us-ascii?q?YZAgiMDkleLJBSBEQNWDwEBAQ0BATETBAEBhQYChxUCJjQJDgECAgIBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBAQEBHhkFDhAnhWgNhk0BAQEDE?=
 =?us-ascii?q?hUZAQE3AQ8CAQgYLjIlAgQOBQgaglwBgl4DAagsAYFAAoooeIEBM4EBggkBA?=
 =?us-ascii?q?QYEBbJsCYFIiAoBigYnG4FJRIEVgTyBbz6CYQKBRhoHhhoig3aDG4IgBzKBC?=
 =?us-ascii?q?gwJgQODLiqBFIooXiRHcBsDBwOBAxArBwQyGwcGCRYYFSUGUQQtJAkTEj4Eg?=
 =?us-ascii?q?WeBUQqBBj8PDhGCQyICBzY2GUuCWwkVDDVNdhAqBBQXgREEah8VHhIlERIXD?=
 =?us-ascii?q?QMIdh0CESM8AwUDBDQKFQ0LIQUUQwNHBkoLAwIcBQMDBIE2BQ0eAhAaBg4pA?=
 =?us-ascii?q?wMZTQIQFAMeHQMDBgMLMQMwgR4MWQNvHzYJPA8MMwNEHUADeD01FBttnQNwg?=
 =?us-ascii?q?mh7FCkGgVYqEB6WJwGNSKEuCoQMjAGVHkkDhUGkE4UqglKQQKgmAgQCBAUCD?=
 =?us-ascii?q?gEBBoFjOoFbcBWDIglJGQ+OOYNfhhWJZHY7AgcLAQEDCYtKAQE?=
IronPort-PHdr: A9a23:s+3/hRUc7jhwxIt0sJQ9kz1HjpHV8K0yAWYlg6HPw5pHdqClupP6M
 1OavLNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2s2y1uuv/5TISw5JnzG6J7h1K
 Ub+oQDYrMJDmYJ5Me5x0k7Qv3JScuJKxGVlbV6ShEP64cG9vdZvpi9RoPkmscVHVM3H
IronPort-Data: A9a23:FZbpL68k55thSQYpodhUDrUDXn6TJUtcMsCJ2f8bNWPcYEJGY0x3z
 WQZX26AOKyCN2b3L4x0PYmx8UxT6MTUn9FnTVdvritEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmE4E/ra+C9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4upyyHjEAX9gWUtajtFs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0JTKEUC94emK9kfPeWv86fo3LUZxOJJNr46bAUkWn
 RAZADkJahbGjOWszffgDOJtnc8kasLsOevzuFk5kmqfVqhgGMuFGv6UjTNb9G9YasRmFPPfb
 NcdYCFHZxXbaBoJMVASYH47tL7y2CahL20E9jp5o4IxzkfalzZ934S3OeGNV5ugS+p6v02H8
 zeuE2PRW0FGa4P3JSC+2natgPLf2CD2QoQfEJWm+fNwxl6e3GoeDFsRT1TTieOkkVL7VdVFb
 kgV/Dc+hbY9+VbtTdTnWRC85nmesXYht8F4Guk+7kSGzbDZpl3fDWkfRTkHY9sj3CMredA0/
 nSEr+vrVRl2ibecQ2KN3LjNjDT1PDdAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdRGGYL
 9ei8XdWulkDsSIY//7gpAya2lpAsrCMH1FtuFSGNo6wxl4hDLNJcbBE/rQyARxoAIufUl6H1
 JTvs5fAtrlWZX1hedDkfQngNLit4/DAOzrGjBs0WZIg7D+qvXWkeOi8AQ2Sxm83aa7omhewP
 yc/XD+9ArcPZBNGiocsPOqM5zwCl/SIKDgfatjab8BVfr96fxKd8SdlaCa4hj68zxZxyvFjY
 87DLa5A6Er274w5lFJaoM9DidcWKtwWngs/uLiilU38iOrCDJJrYe5caQrmgh8FAFOs+VWJr
 Ik32zqiwBREW+q2eTjM7YMWNjg3wYsTW/jLRzhsXrfbeGJOQTh5Y9eImO9JU9I+xcx9yLyXl
 kxRr2cFkjLXn2PcEwyWZxhLMfW3NXqJhShlbXVE0JfB8yVLXLtDG49GKcVnJeJ2rLc8pRO2J
 tFcE/i97j10Ym2v0xwWbIL2q8ppcxHDuO5EF3PNjOQXF3K4ezH0xw==
IronPort-HdrOrdr: A9a23:ZNI2d6mcfDbNg/FI43I/wjLEM//pDfNQiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtjwfZq9z/JICYl4B8baYOF/0FHYYr2KnrGSswEIfBeOt9K1tJ
 0QPJSWbeeAb2SS4vyKnTVQf+xQp+VvtZrY+9s2rE0dDT2CCZsQkzuRYzzzeiYZNWw2YabRVq
 DsmfavzADQAUj/G/7LfEXtKNKz3OEj+qiWByIuNloM0iXLpzWu77LxDhif2Tkjcx4n+90f2F
 mAuTbUooG4vd+G6jK07QLuBpJt9+fJ+59mPoihm8IVIjLjhkKDf4J6QYCPuzgzvaWG9EsquM
 OkmWZjA+1Dr1fqOk2lqxrk3AftlBw07WX59FOeiXz/5eTkWTMBDdZbj44xSGqd16NghqA57E
 t45RPei3NlN2KYoM073amRa/herDvynZPlq59Js5UQa/pFVFYbl/1twKocKuZzIMu90vFlLA
 GrZ/usuMq/tjihHi3kl3gqz9q2UnspGBCaBkAEp8yOyjBT2Gt01k0C2aUk7z09Hb8GOtF5Dt
 7/Q+9VvaALStVTYbN2Be8HT8fyAmvRQQjUOGbXJVj8DqkIN3/EtpayudwOla2XUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO9hzWWm2yUTnk18kb7Zlkvb/3QqbtLES4OR0Tutrlp+9aDtzQWv
 61Np4TC/j/LXH2EYIMxAH6U4k6EwhWbCTUgKdMZ7ujmLO9FmSxjJ2vTB/6HsuYLQoZ
X-Talos-CUID: =?us-ascii?q?9a23=3ARKliX2seNGZZWwnDlAtiOINK6IsOf03lzif1Ona?=
 =?us-ascii?q?yAGx5WJeaEH6Xv6Z7xp8=3D?=
X-Talos-MUID: 9a23:nbGhtQhVcarYrPc0wlR7H8MpMupH6v+UBE8xy5w94+TDHyJfFBaWk2Hi
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 18:49:18 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 39JInIAY025524
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 18:49:18 GMT
X-CSE-ConnectionGUID: x+ljMh41Rpa49QSU+GIOSw==
X-CSE-MsgGUID: A1l6kFD+SfO43jjnrCuyhQ==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,238,1694736000"; 
   d="scan'208";a="5382320"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 18:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjppLPqKvxboQGIjsTOQRF+wjYAjm4BZouDL+AvmGVzgRAQVyvyFjNCDawPAXwY2FToloYp/CPhkBpOYLoKeHOYQEWIXdfWAbsKDK/kNwUCAYBhuY23dJuyes2y05c3gUh3O4J+EjgDBTX1VRBf1b6CHBmREH0fihg5NVESxp3xint3p+LvpweDgRuKII8LLgAjRGpZ9viFk+CAJpHnCSxsor8eAVMy/06qLDTtIGw4/q5fgX9X/KhUf8W2wqbtEXUE6yzc75pS2p/eV/WlH833W/8SeEVIBOZDHfddxnEp1ziXKL/9xsfGS3Fyj7Ig89e7hJ6HoLiSerHseFYokuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0RBuQO7tUtphn4pCKsUQ8do2EDtloDyT3gNv5aAJyg=;
 b=EAw3Gusn5YFPhY3k93P0lyBo2r9tR3xrccOlXVD3ke1Sl07jtss6tJn1Bx7B2dmtNrCDbCjwgyAQ1at39rhYZClrzhWUSmJ65qwfAISHUbqMXc+nHZmleo5kPbQ5tjfyU4yWOg8YkLxhnp0neBRFF5eBDXVF4VLA4XrTh3U9y++ays4ykanuOK0gvTSwaW159AXx5/XcyAwbKdnI2BlXD9tDOJwCnMT7YCOX3njLL4P/SOD2xY3aJLVGCQCh/MqioRyQNS7hAdeI2qjZ37+wbQiGav1xNw8Ulbj5nC9cPldoVukCb/K0YJoH/Jj61oPy/TYzdalU2Ao1zgH1HLhAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0RBuQO7tUtphn4pCKsUQ8do2EDtloDyT3gNv5aAJyg=;
 b=csM6umGnX+BaPj+YQZZWzXhNeVVEvB+A32jTcBR2kTE6hhsPofpfSOSK18OxM6lxkcP8E2hsREzLJN8r8Tnp3H9v0nSjSd0mtl/2ibK2DouO6Z7I5k+EKPPGKNr3GBfFzDVjVC13+Zy9F1PqmqvbCuRRstCL+ADzCDmJWzJtqdk=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by SJ0PR11MB4912.namprd11.prod.outlook.com (2603:10b6:a03:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Thu, 19 Oct
 2023 18:49:14 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::6c6c:63b0:2c91:a8d9]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::6c6c:63b0:2c91:a8d9%7]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 18:49:14 +0000
From:   "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To:     Benno Lossin <benno.lossin@proton.me>
CC:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: macros: improve `#[vtable]` documentation
Thread-Topic: [PATCH v2] rust: macros: improve `#[vtable]` documentation
Thread-Index: AQHaArz0jXJRfEzbbUaGYI2Vxgswdw==
Date:   Thu, 19 Oct 2023 18:49:14 +0000
Message-ID: <2tucqxnvhh3db4mc73fyahc7w2xxawaupzgxzvmhxavkbeffzn@sj4dhsipcs5a>
References: <20231019171540.259173-1-benno.lossin@proton.me>
In-Reply-To: <20231019171540.259173-1-benno.lossin@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|SJ0PR11MB4912:EE_
x-ms-office365-filtering-correlation-id: de70ca6c-5ba3-47be-1b9e-08dbd0d4175f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYn5+fusbyddk1IBQ+Fj2XvPEWQnVI1ttPcEjbCFBHP6Y8ll31BkUOERhkP0lip9CggUS+Uy8Fsw9q9VBHzUQ5DJYy9IfiATMakJyxTBIppcpqnfC6CTVAyRkJjjGlSh24YAQ6xRL51U6BTGfSHVIB5WBBbS7ys4yJV1rYqMuGeQdCZrYWmZyqGLvvfZq//UsWA3xYtcOQoFThem6Gnx6gyZBgetiRB1VL/GI+eRr2Z4H28kPP48ISRTdvN9DXrHqwavOB8dWzIlC392mb/QxsHamLkANsI2NZDj4fIQFDut/2JViHAfO725KsDW5xe9lSxfz210KKV4EHsKsdLpu+6qle/NqN9uNhYJRUEOULw2Mj3alm9ndQmDvPHD04KNJz3La1sfqB7abZz3ZRBN34QN/Tx4F9Oz+XGkGCvrS9RiYWSqSGnM7Z4s8DpoAZHuJZAzMUR4zxkR8O7gtuh0Pe7byMAWU2CvFqQmzY2s9phY0rYsy0O8C8JF73Frxv0+NUFP0GmFvfrprVwEl9c8K4A/qOisbIOykdn4whotfLifYgo6+ZcjAMAgZLLGM6fbHMZZiRzynhGs5RbltwUetICP4N0QLY9VunFMKj/gZC/WCi+QiMHElcgVjSVjTBRX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(2906002)(76116006)(66946007)(91956017)(66476007)(6916009)(54906003)(66556008)(66446008)(64756008)(316002)(5660300002)(71200400001)(8936002)(478600001)(6486002)(86362001)(41300700001)(8676002)(4326008)(7416002)(6506007)(38100700002)(9686003)(6512007)(83380400001)(26005)(122000001)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DF90zfXi2UGhEG61nToo+JcmoTTK+UK5ajJ0SChE7xQQQaSrJETJaNKVwa?=
 =?iso-8859-1?Q?9L/zAZOAojbamnfFJYTvhC7ZMtMmZ+YoOOpoJueCln5lXEWBlxkmwjdOzj?=
 =?iso-8859-1?Q?bv2BEN18WcnrKhuf/ZZkH24yD25YiwsM1WWyGg+fJXWBOO2P1KxR6qgFwT?=
 =?iso-8859-1?Q?F6CIRSN0U9SvPITHQFxQI35Xtx1rB27j5yJU477CmRtN27yFIfAnmxud/t?=
 =?iso-8859-1?Q?PkXfNihnkmKTezewjj0AbNpvadvKvjih9KUfUSYZZc6lqN8pjxgCKzOiL2?=
 =?iso-8859-1?Q?5a47S5IiVbcATS2HmTyY4jpnkRkEe9/XH2BTIdPciZH8kszQ1bCgtFHg0n?=
 =?iso-8859-1?Q?GKYaGl2t805WE8M1+rYgkRE7pvKNfAHjdJlO1ix+4SxO1KZrftSs7dhr4O?=
 =?iso-8859-1?Q?/wZXnc6fSycPwyoEJvO71fdwRZcK7CxVBGH4ruT0NkrsqQtFfaThQiMZH2?=
 =?iso-8859-1?Q?93KSo4etzqGnSM4TC6nGdSyBJJgHUCfIgxlAk8VHohkJ6vhaXxxSI4EkNW?=
 =?iso-8859-1?Q?3QxDvOyps2EcvE8Cgsbfpzerq6rG5fR+p7Zcm4aoBFoE8XENuhm657pNIj?=
 =?iso-8859-1?Q?urSe16dYPAsrVrvq2mmP6cu8m7IeDfgCddVtEyv3W02EMFFFsRlbuqmpYN?=
 =?iso-8859-1?Q?7cfxySVYVlAUSHjaRUzQTSfEvOdZArbwvrb2ZLuCvY8jSUJ6SEkYidVz8b?=
 =?iso-8859-1?Q?JTl7TGDqoRdef38MgluymxioaLi1JHD9V0PuiUK28A8IFICtZaelK9Ee4x?=
 =?iso-8859-1?Q?zs/cMUCErGrHWmds1i+I+gfpivgkPuvy+tQn5sqNmV3lfbvjPOvAAHRx40?=
 =?iso-8859-1?Q?/02M2YdHM7MX+1oIqqJX/qVY8hQeO759hj99+cnXBni6xPZJxCG0qzpbUd?=
 =?iso-8859-1?Q?G/EUWRIsePDAtluaUkVv+Cpx5pLMX+sIBucseIsq9bkOT+kcBDqEK12IZU?=
 =?iso-8859-1?Q?e2L0eJdQBcpTejea0jayep3VOrsZz+94tYK91HHAwramD1u+TFU7Lr/UAJ?=
 =?iso-8859-1?Q?Mp8D5eIFnJpwwA3SayUoWHc9h0b3gyzm5gkS/FF2f4HQzwYkzABp0Ga77c?=
 =?iso-8859-1?Q?wWEEqpVyvB9P73Fo3dJcOB0tyQJnQNWvBtslemFMJgqKsDTyIB833rSXSs?=
 =?iso-8859-1?Q?VIgC/rv3Cs9/811O92BQ/9O+zdFsHO0I22/nFPVD8I8LIxNf4YAnxQ8zO0?=
 =?iso-8859-1?Q?ngUchDpgtYYBqm+rXgEVt0l+Ci+pxF00BX6s3gQtuVTY2XP4FdaJ6vNI2k?=
 =?iso-8859-1?Q?jwO1U+YWfLfUfDrW4SlN50kEWvcSnw7cjPA25Xb1aCx/2e//vbjMR7iQus?=
 =?iso-8859-1?Q?r8/av6VzNNPG0UCBLf/Dyq65Y9ffF9gaJ+AkwOgDbBiRD+s33wg0zGwa0d?=
 =?iso-8859-1?Q?sXGZlZFGbN/udQhDVdxa5p2yhzn8joPbXs5hoMxxTwEMcQ56JIip8qrdKH?=
 =?iso-8859-1?Q?Rept0EDmmL5G/WOrZlvEpx5ZL6q9538LoUA+gxmPMGDUAydym6suOvi/BL?=
 =?iso-8859-1?Q?QcLcromuJKajv0/6mqdaaPfd44AURfvZdIbqB3pMjEIrXoF9UHsw80YQW3?=
 =?iso-8859-1?Q?MsaTSrMenoIktj5NDPSeQ4uODpRXITGv9n1ypVbHjtP0gzxeOjsYg7xUJx?=
 =?iso-8859-1?Q?i6sLkmI/mDIpO3QF9BInuTi7yHAjV/6PAX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F1AFA628D1F9A345A76B447EB5E145CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de70ca6c-5ba3-47be-1b9e-08dbd0d4175f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 18:49:14.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMeZuv0vA5gA6W0agBaTWKSIQUvgPQ3RQqg0qzBdobtQLoE6mdz5DkX3OaVFJlC+KHTBjyiG2LxlAh7avpEP/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/19 05:15PM, Benno Lossin wrote:
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
> v1 -> v2:
> - removed imperative mode in the paragraph describing optional
>   functions.
>=20
>  rust/kernel/error.rs |  4 ++++
>  rust/macros/lib.rs   | 32 ++++++++++++++++++++++++--------
>  2 files changed, 28 insertions(+), 8 deletions(-)
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
> index c42105c2ff96..daf1ef8baa62 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -87,27 +87,41 @@ pub fn module(ts: TokenStream) -> TokenStream {
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
> +///
> +/// For a function to be optional, it must have a default implementation=
. But this default
> +/// implementation will never be executed, since these functions are exc=
lusively called from
> +/// callbacks from the C side. This is because the vtable will have a `N=
ULL` entry and the C side
> +/// will execute the default behavior. Since it is not maintainable to r=
eplicate the default
> +/// behavior in Rust, the default implementation should be:
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
> +/// This macro should not be used when all function are required.

Typo: should be `all functions`
>  ///
>  /// # Examples
>  ///
>  /// ```ignore
> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
>  /// use kernel::prelude::*;
>  ///
>  /// // Declares a `#[vtable]` trait
>  /// #[vtable]
> -/// pub trait Operations: Send + Sync + Sized {
> +/// pub trait Operations {
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
> @@ -125,6 +139,8 @@ pub fn module(ts: TokenStream) -> TokenStream {
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
> base-commit: a7135d10754760f0c038497b44c2c2f2b0fb5651
> --=20
> 2.41.0
>=20
>=20
With the above typo fixed,
Reviewed-by: Ariel Miculas <amiculas@cisco.com>=
