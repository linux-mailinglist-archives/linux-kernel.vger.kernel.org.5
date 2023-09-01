Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F678F65C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 02:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjIAAXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 20:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjIAAXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 20:23:38 -0400
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18FBF4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1566; q=dns/txt; s=iport;
  t=1693527815; x=1694737415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eavAh/9LviJ9yfN9+i5MTmA6UX9SLbRNrDAKHSOD6Wk=;
  b=G7MnPy8dcPf9+BOoHlO4tnX8hec/4qQNyn0s9UnS1EsHH2/lfv2k6Gqs
   35TcS38ditoupiBnFbWiokCW/ayCgTMjnqMMmLHOhbYPQ9996yVQiF5+Z
   7VdQ0nhfe68VOC9nA85LBPYeacbPjf5vwpPZZFKZLTKgRWfpTuUA1oKNo
   g=;
X-IPAS-Result: =?us-ascii?q?A0ArAAAELvFkmJxdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEWBwEBCwGBZFJ0AlkqEkeIHQOETl+IZ518gSUDVg8BAQENAQE5CwQBAYUGA?=
 =?us-ascii?q?oZrAiU0CQ4BAgICAQEBAQMCAwEBAQEBAQMBAQUBAQECAQcEFAEBAQEBAQEBH?=
 =?us-ascii?q?hkFDhAnhWgNhgQBAQEBAxIoBgEBLAsBCwQCAQgOAwQBAR8QMh0IAgQBDQUIG?=
 =?us-ascii?q?oJcAYJeAwEQnSABgUACiih4gTSBAYIJAQEGBAWybAMGgUQBiAcBhTKETScbg?=
 =?us-ascii?q?g2BWIJoPoJiAoFihBKCLolghUYHMoYIiRgqgQgIXoFqPQINVAsLY4EVgkcCA?=
 =?us-ascii?q?hE6E0pxGwMHA4ECECsHBDIbBwYJFy0lBlEELSQJExI+BIFxgVMKgQU/EQ4Rg?=
 =?us-ascii?q?kYrNjYZS4JmCRUMNE52ECsEFBiBFARsBRoVHjcREhkNAwh2HQIyPAMFAwQ2C?=
 =?us-ascii?q?hUNCyEFFEMDSAZMCwMCHAUDAwSBNwUPHwIQGgYOLQNEHUADC209NRQbBQRmW?=
 =?us-ascii?q?gWfXHCBaIIkgQUTlF+cUZRkCoQLi3+VOxeEAYxul2GBD5gsII1BlnODSAIEA?=
 =?us-ascii?q?gQFAg4BAQaBYzqBW3AVO4IzAQEBMVIZD44gGYNehRSKZXYCOQIHCwEBAwmLS?=
 =?us-ascii?q?AEB?=
IronPort-PHdr: A9a23:uyEGDRIzArJqF79b6NmcuakyDhhOgF28FhQe5pxijKpBbeH6uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1o2t2qjPx1tEd3lL0bXvmX06DcTHhvlMg8gJe3vBo/Whsef3OGp8JqVaAJN13KxZLpoJ
 0CupB7K/okO1JJ/I7w4zAfIpHYAd+VNkGVvI1/S1xqp7car95kl+CNV088=
IronPort-Data: A9a23:0EvMGa5uCAOaDCgfPH7cXwxRtC/HchMFZxGqfqrLsTDasY5as4F+v
 mIYDW2Bb67cM2KmKdt2O4i18ElXu5XVndFkTlZkpXgwZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyOa/lH3WlTYhSEUOZugHtIQM8aafHgrLeNYYH1500k7y7Vg2tUAbeWRWmthh
 /uj+6UzB3f9s9JEGjp8B3Wr8U4HUFza4Vv0j3RmDRx5lAa2e0o9UPrzEZqMw07QGeG4KAIVq
 9Hrl9lV9kuBl/sk50jMfrzTKiXmSZaKVeSCZ+Y/t6WK2nB/SiIOPqkTLecgcF9MrCSwg8FNk
 tpdscLuVTsRF/iZ8Agde0Ew/yBWJ6ZK/vrMJmKy9JHVxEzdeHyqyPJrZK00FdRHoaAsXicfr
 rpBdW5lghOr34paxJq4Q/Nwh8AqL+HgPZgUvTdryjSx4fMOGMiSHP2Qvo8FtNs2rvxpBvDiR
 +gVUgBqN03yRzdpIlM7NLtryY9EgVGmI2EH9zp5v5Ef52nV0Rw01rX9LPLLddGQA8ZYhECVo
 iTB5WuRKhUbMsGPjDmI6HShgsfRki7hHoEfDru18rhtmlL7+4AIIAcdWV3+qv6jhwvjHdleM
 EcTvCEpqMDe6XBHUPHkQiGhuGWjrycASuYKHP0+tl+R9pL9tlPx6nc/chZNb9kvtckTTDMs1
 0OUk96BOdCJmODJIZ563urKxQ5eKRT5PkdZOnBZFVptD83L5dBs3kiWH76PBYbs1oWtcQwc1
 Qxmu8TXuln+pdQA26P+9lfdjnfx4JPIVQUyoA7QWwpJDz+Vhqb7P+RECnCCvZ6sybp1qHHa4
 RDofODFvYgz4WmlznDlfQn0NOjBCwy5GDPdm0VzOJIq6i6g/XWuFagJvmAleR83bJpYJGK1C
 KM2he+3zMELVJdNRfEvC79d9+x2pUQdPY2/D6uNPoYmjmZZLVPep0mCmnJ8L0i0wBRzzsnTy
 L+QcN2nCj4BGL97wT+tL9rxIpd1rh3SMVj7HMihpzz+iOL2TCfMFd8tbgDUBshnt/zsnekg2
 4sFXyd8408BALSWj+i+2dN7EG3m2lBhXsys+pEML7TeSuekcUl4Y8LsLXoaU9UNt4xel/zD+
 Te2XUow9bY1rSSvxdmiApy7VI7SYA==
IronPort-HdrOrdr: A9a23:bab7I6sAmIM6R9qVcG5bdVmb7skCM4Aji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwSZVoIUmxyXZ0ibNhRItKLzOWyFdAS7sSo7cKogeQVBEWk9Qtt5
 uIHJIOdeEYYWIK6voSpTPIberIo+P3sZxA592us0uFJDsCA8oPnmIJbjpzUHcGOzWubqBJbK
 Z0k/A33QZIDk5nFfhTaEN1OdTrlpngrr6jSxgAABIs9QmJih2VyJOSKXKl9yZbeQlihZM5/0
 b4syGR3MieWveApSP05iv21dB7idHhwtxMCIinkc4OMAjhjQ6uecBIR6CClCpdmpDt1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6jh2f5q8CRfkN5NyMBv/MdTvLq0TtmgDhO6t
 MM44tfjesPMfr0plW42zEPbWAzqqP7mwt4rQdZtQ0tbWJXUs4ikWVYxjIULH/FdxiKtbzO14
 JVfZvhzecTflWAY3/DuG5zhNSqQ3QoBx+DBlMPo8qPzlFt7TpEJmYjtYQid007hdkAYogB4/
 6BPrVjlblIQMNTZaVhBP0ZSc/yDmDWWxrDPG+bPFyiTcg8Sj7wgo+y5K9w6PCheZQOwpd3kJ
 PdUElAvWp3f071E8WB0JBC7xiISmSgWjbmzN1Y+vFCy/DBbauuNTfGREElksOmrflaCsrHW+
 yrMJYTGPPnJXuGI/cB4+Q/YeglFZAzarxjhj9gYSP6niviEPyfitDm
X-Talos-CUID: 9a23:KkKPUWD4ti5WQt/6EzB6yFcMAec0S2HM8C3fM0vmV3pVcJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A9WnmUgxKJF6zMNqr563rB3V5Ud6aqJiJE0Yxsbc?=
 =?us-ascii?q?KgPOBbnVCHx27lDCbfqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 00:23:34 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 3810NYkl015032
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Sep 2023 00:23:34 GMT
X-CSE-ConnectionGUID: tnkt1BSqTkqRCZTAN2/g0A==
X-CSE-MsgGUID: XnG+WwkeTge1eTq/LK1Zjg==
Authentication-Results: rcdn-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=kartilak@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.02,218,1688428800"; 
   d="scan'208";a="1203741"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by rcdn-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 00:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTp5COoCBPr7OT0ChhsDrUmnExTm0xIBKa5kdqp+/c+V7J+JnYI2lw8VgwrQvE0xm4QuZ+opF3z0UAfUfBcMUMQor27ktzkw7zm+zMtAUdGyPlIE/srIM8gIkUHbo8lsa+vc0sXewCaThlLu+N5QQsQqPtgUUQSKhGnNMOEV0z7WVLHTF6b1g3qTTfnyOdV0uu7Fq/TGK6uPvKLNy9jN57Vk+b92FWFeEV/TdaEzrBB3WkHd2SVQzjGrnForeNPO12NgC6kcqibrIY+ygiT/N9vLyGk5CMOmYUQfGdHqG9t4ACnZmwTnoWXNwESG65hCEjsEbngPn9X0rYmpfJdDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YQhrMlE7IVGqlUFfSjW7DxJmZEgR1ldDDw7nc0gCRE=;
 b=Za9eoIFJ/qxxA0qLAEA36Q15btxQcPejCXOQBAUbGYHhOAGT4kBfUQ8NB7LSzUB+2XxJ+TlqzWFZVAraPTnAfwQR/f/eAtNQ699W6rnPGGoIHuB8qRIUJmds8kLuvv+jW3EtM0TyFemCko1imu9dpg60QRVCjVsqZqY994vxgIoc5j7hrIJXkF/Bote0d4thZAvHHWR5NWrmkmbeARF53ugSj3Y0tQcZjaU5LRI6KKnPK6+f1oDC43PvK7UN6U20zRGI+zNNZ3T0TxCt+w9OPr7UXVFdSTDmB2lPMfGbUtuGSxriwtgWxraXpWJ5ZI37vUZpVG3Quso8p9LFi96pcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YQhrMlE7IVGqlUFfSjW7DxJmZEgR1ldDDw7nc0gCRE=;
 b=OB8uMrZgAZqSQCo5BnqT9NDnuz6L+575+yTQN8Xqqe8kzyrBGjoL6KV/6A4MgSzVk1n8vP+Zmh/ckKBs5RdlIKj6fanTYLMLjx95kw41wWfeTsV7SvbCk7+Y7sgPx16+fp2cBE8bzNgKayo1f0b1BmXIldjHhiwZYukL7h11Nqo=
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 00:23:31 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::cdc6:d9b7:ff6e:bec5]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::cdc6:d9b7:ff6e:bec5%4]) with mapi id 15.20.6745.021; Fri, 1 Sep 2023
 00:23:31 +0000
From:   "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Thread-Topic: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Thread-Index: AQHZ2VwrqtyDy5cVYU6WgbTOst77QrAFIaxQ
Date:   Fri, 1 Sep 2023 00:23:31 +0000
Message-ID: <SJ0PR11MB58964806CF716BB19A8F1DD3C3E4A@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20230828130240.4814c106@canb.auug.org.au>
In-Reply-To: <20230828130240.4814c106@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|BN9PR11MB5322:EE_
x-ms-office365-filtering-correlation-id: 81fd8560-fce5-4ac4-dd72-08dbaa81ac18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Y3Hg5hrQ1iOM/WOuwtPlYvii9BbsAPf6Tp1cCchL56uhrGXEKezMo20WaddVx6If+5pTRWXLs8vUh9iVLyzHZK8QA6Nzl1jceHj/wJu1pN28s0Rh6lR32qOJVrzRgGmH8w7GzNXtf6oeAEIJyNuyZlThZUZE+I4S+A1eFIQ6cl1BIBHJ4HfOWAHCvZQJaEMPT/bkhGp6jSWPUr5ZpT6F+W0BSfGhd64XMUYA6XhOEyiy8UNd38UlZ3Z7iJudU/z/rHHaeI0XF2ZBOPyFQqGfLTn53CjowtHUTPnoVWu9rhSTGWhYmg282rkfXHUER334GcXRLjHAmO+JJLcljUCPT5vJjWqmGnGyqAomZk7JNnFZR6HY/twx4Xt2hO/u3NVaMeMnNUEeAvSvT3xlCiI99qk1Wf/0JKkfSfky4oscs0H7v5F1Esg5+/Yy5mkHwm/ZDBz06TB/VXIkJUDjqMzwlAvzhALJvO4mFLhSxkDCzPWEV6TQWe5RKC2zd8fdaoYhM6ONusNIOS66hVryLubCUtVC8p+fPoBe6ibZyuKlKhjQnjVZSPGmj/bc6er4562eOPfaIrR9Sl2AE37v6NZ+q9AWPMuVNPv0xNoN+v4EzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(1800799009)(451199024)(186009)(71200400001)(9686003)(6506007)(7696005)(55016003)(33656002)(122000001)(38070700005)(38100700002)(86362001)(2906002)(966005)(53546011)(83380400001)(478600001)(76116006)(52536014)(110136005)(4326008)(8936002)(8676002)(66946007)(54906003)(66556008)(5660300002)(41300700001)(64756008)(316002)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bWrt2HHtd6zFOi30jB2XqnZ8db34GNkHqXWpBaUXL76FIfDCdJruVVk96xsC?=
 =?us-ascii?Q?7pcyeE54BZbSRZZrGjQeoJJQlL9tSZvUENKaPUdh0D4r4sAQuMJMNOCmdwZW?=
 =?us-ascii?Q?CX4pdJw0vIhps3Bv7NSNT+24fAcwcpXPKQu/AmPDhaZXiP+tIHtu77+AsLQk?=
 =?us-ascii?Q?eW1Qy36SGvuA10ydcH14sVfADaUM7xw1Zp62PnGTFSvDw1bZpNSe7ZbMzrQZ?=
 =?us-ascii?Q?T9jV17uR8U+we2pO3/4/97BLfWM5O24xLwnDGl+pSftV9JWUiib6VN1hJDVP?=
 =?us-ascii?Q?QWnapoxnOKRS7Ea/dw0aHswZkm1q/9JO5LGZ1Tk8GxE4pPu0KdftALnvnGPw?=
 =?us-ascii?Q?eZG4/6fLHaxzX/yO2S4mvUSY02FdiStWrBslNEuBnRVZG4tK7pVlO9oxjgAt?=
 =?us-ascii?Q?3IeJLeU8Y/V1+jPlmRpIrn5Eq/HGLrNXoXXp+/67mh5kABRsxeK8Fae+uliw?=
 =?us-ascii?Q?vHS2Bgbe4L1MqISjXzv4q4hTwDsGTJgXfZd1IZpfE8hoCZpiGE+3Sph4Nb6t?=
 =?us-ascii?Q?SZMqPm8Ir0o0I6xhaMv+cWuWlvaFvFxtd6jItDhd1Oky6KMBcVulTkupVzlP?=
 =?us-ascii?Q?2tPUzG+WFoKNsUaohAkvMsclvzXN5Xnofd/3BWerltjzbHCkVa1fHejByTfP?=
 =?us-ascii?Q?GUG8KR92mCgpuylqEydZR3HUpOyav2c9ZNnee5+TBfGxVZNm7pCiJJyYQnUP?=
 =?us-ascii?Q?4h0aUTYG08T//wEJuSga41yAftg34tj9da0RHES+DRTzE6+1jNi4cslpz5y8?=
 =?us-ascii?Q?KztdKGaBKCgr2e3JZHdfm9BV+Tlpb17mC8ZZKN+05pwrfCPHNlbckYkC6Upv?=
 =?us-ascii?Q?Vuv8Q0xNiYqVZGq3hQQphIKnw0Fd7FjK2rmlNL0y3XruNrraPhX5GoLezKuc?=
 =?us-ascii?Q?VXcGbX/gvGkqpXfCStWSKxEZTfGEo+1c4yxo/HoOK35eE47eXsPub99NtMys?=
 =?us-ascii?Q?j+jSzde3M9L/v2Y7IBavPTkItuDTPVYVZoCdiq0fGz9slQokgmDw62bUBXuz?=
 =?us-ascii?Q?iGfqylKv6aUVay5xhY/V4LDZvaWND+ie3H6CT+0ODngRGw1MxM5gnJqFFur7?=
 =?us-ascii?Q?j6htz8dUQeHeI1wJpzHGtVR74FWjo6i9lq1oCcOEybNt1mSBLHMpaNo3kTkG?=
 =?us-ascii?Q?Ta9XWX+JrRyZHfOxFotVVS91wXyyVKVAw2kwFoNW4WJoKmC7pgseyKz3yJmG?=
 =?us-ascii?Q?6nfXMHwpxkoZcm7MH1DPKg866YmXkx6crtJIAyHqBkE6g0qdqdRNTLfnrY4u?=
 =?us-ascii?Q?m6TuaSTjFgT9fxWjb+EentcoirEeqdYPMY930WgSHSPs9VtBe5MWmutOX7IT?=
 =?us-ascii?Q?OD1bISbYWrSJ3wSfiSXQorabwKX7AI38RMUPewRNQUOEQgMyt7nyPgWoI7YK?=
 =?us-ascii?Q?0eaXsNgg31V1vTbKCAUO9SUb1z85Wipm0k1Rec2lPyYzg8EgUQ4YhOkMMps1?=
 =?us-ascii?Q?/SJYrF8rPpR4PM7tvCP+CbBUrx/V4UXj8PQZw1NAPqPy6yQMb/Rnu68WfxiB?=
 =?us-ascii?Q?dNY7L+zuQWn6S8UoDho4hQNYSvgzrR+NIIjtWJTbvBSzjCSv44aiyOUc9iX9?=
 =?us-ascii?Q?exNVX1qDsPV7TPrnqxslQmssz2NmMf+VnnFc0M6FEWtDavBuc0+dENt0OZc6?=
 =?us-ascii?Q?wyFYcF5pH8LolwwDFMyPvzhUXl3b5C3vpFgSpKqPorj3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fd8560-fce5-4ac4-dd72-08dbaa81ac18
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 00:23:31.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Te7pTc9mbiX0jErxxjVeOj3Cv0Ss+pE/8B2A1l7znX9NkRSQT2H4GptqDklLVcfd/T28yBwRxlw3+Yj8h8PMJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5322
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com
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

Hi Stephen,

Thanks for your help on this.

I cloned this repo, and checked out the master branch:

git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/
git checkout master

I don't see these two commits there yet.

Are these commits scheduled to be merged sometime soon?
Please advise.

Thanks,
Karan

-----Original Message-----
From: Stephen Rothwell <sfr@canb.auug.org.au>=20
Sent: Sunday, August 27, 2023 8:03 PM
To: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Karan Tilak Kumar (kartilak) <kartilak@cisco.com>; Linux Kernel Mailing=
 List <linux-kernel@vger.kernel.org>; Linux Next Mailing List <linux-next@v=
ger.kernel.org>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/fnic/fnic.h

between commit:

  5a43b07a8783 ("scsi: fnic: Replace return codes in fnic_clean_pending_abo=
rts()")

from Linus' tree and commit:

  15924b050363 ("scsi: fnic: Replace sgreset tag with max_tag_id")

from the scsi-mkp tree.

I fixed it up (it was just the version number, so I used the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell
