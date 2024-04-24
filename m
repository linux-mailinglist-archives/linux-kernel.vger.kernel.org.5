Return-Path: <linux-kernel+bounces-157771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A908B15FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A9A1F237DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E2816C423;
	Wed, 24 Apr 2024 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="JBjWALFV";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="e6C+PwTA"
Received: from mx0a-0068d901.pphosted.com (mx0a-0068d901.pphosted.com [205.220.168.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A983E15FA70;
	Wed, 24 Apr 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996921; cv=fail; b=Old7uYRea+fytyy1bNNyEjwHQsZ7GDbQdRSytfS5u3u++3EYUP+9IKLmg0xd1pqhuY0Ezjodz82hbRe0RnZKWc47aVAJYiXX9HTS5Y/z04TeaScTct+40JKuaNxdSLkIGJX5QnXFWZxlvwzjWoTkRpUGTH7h/kXjoLwwslFMyRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996921; c=relaxed/simple;
	bh=iocbcIDEZW7SOGQ+hUYocWe9D78pt5pTaNfwmfo9Mro=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u0dY7mzMrAvYZlDQoK4YpTDM+8aSojMIxNvOvJMxuL0vsghtCUnSD0zBcbznHuoOh5FVaOKlaBSKkQC9sSYNbBacQxALAeS43z60rAw1Z2D6qEQ+v2Lg0rYkcMd5KD7G9zv+HGfnaYGs4nm0aKLT8JFoKND5ZDUijvhzlF+VpQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=JBjWALFV; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=e6C+PwTA; arc=fail smtp.client-ip=205.220.168.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278264.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OAU2cl028125;
	Wed, 24 Apr 2024 15:15:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=proofpoint; bh=HS65Vr
	ZOowJuMIjMztvWiAqOyu9KWF99n3S2eLEu0RQ=; b=JBjWALFVrv0Uig97/J9wu3
	D4LBMPoIrHNVdJ0syD/gxLMMQOvRLAk6zMp6zhe82LS1kXzlXaZmbOOUwBcJJeBq
	oaewciFGEfKv1NN5SoE1hl0UrCTSATDn1c7bGSiU7hgnq3x1HteDAgeHjTnO1O5u
	bWM1EKcqndTpXa9BveItQJDRMWBV/kkhgrzZ1iqj+fTDD6vheibT7KgZr+yiCigb
	ltV0nmx/ln1lHv8JMexWSEw4eWHW4NZV5Ob/XqDMavoU4EqfK2hfx6AdEqZ8rP3d
	926h/7UE8HIze6qLEnWggqDUavtGjaNUyAStbKnpPTZkFo4thEE/zPKx2z/HBojg
	==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xmcrg3aup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 15:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3YOVz1x46d2Rgo/0+ohbB0cjr5L/bkn1wv4lx0JDmrm/vtFXArSpNHgrJI7rZMqZQHdvN9On0mL51HeGdIYJSZ5EFgGcgpqZ0Wr0Cvjj+9ekLFGMvReDEs2QJfJzEcwRiW9qCuLNMN8w/jhI53rzF+0yLW3CWK0tjppr8amrWyold8GFgvi4PHTP8usQbRnBtQgPbY51k6Erw9RiC3TAkhErX57bdnFWu+CdGYUQDCfXeInDJxY+NIvbY0naxnzbZ+IWNQepwQ6fwZdwQfIqunYK0TtcnwqRK35NxAVWaUiamP0MKfzh7h0Qhy6weihkMHbMbnwViUSyHCJAMvwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS65VrZOowJuMIjMztvWiAqOyu9KWF99n3S2eLEu0RQ=;
 b=SmzR/yopRc/+UwY8fUZGthard3Y1LmQKK7nnav/Y/8sOSNYFRYUT9+7to4p9z29D54yy3vlkYl2inTEbgO7ZMdyU9oVxdD0dwgD2NCsqg41L2brBoc9KoJAeyTw4jd+BV1KZd/SueJ2RHnkhdlqlfFAT7CGgNW19fz3ORAyHBRDJJ1KjTeO99dvlxr6yFfumYTqYdSEeBsdqbtTxR9YUA7Mhg2hp+P/2f6npxGqU/NyRu+5IqP3Enw4QLTY/IKjq04+7fU/RotHo1WOM4U562/1tlqGjQ2smJlg8UhCi5FGxGTpNdf3KvK8VDmrCPvKY0wbh0RNCwEj56sDf+6zgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS65VrZOowJuMIjMztvWiAqOyu9KWF99n3S2eLEu0RQ=;
 b=e6C+PwTALVrpGLJ84ATH9uIaCMxNqFRVsKcWVnZyXlu4A5E99BoT9OtEyMe6kd07ytMGcBBusOR7/inG9uR29YQHeADBympAL1XwUTtejadZLty33s+RLKmbN90Mpf0OrQ08TFYD+JOVJQQ3IkwfuYxEse+jJFa3eMkZDyiPtzTLNyzSD1lW29LY+ljUL0O0UCIaELUg6lAr2WpzUlorIntM2sp3gXvNumKySBR52V0TcbMPszpbVN4ErHWOMqvMklmNgLg/k3lDMw+pk+ghZJcQpiZO1B/LNG4ihGCaN5reTrnCFlSZUrrhdy85520T2CD0kKQx2kdbBOr2uU5YIA==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by IA1PR17MB6925.namprd17.prod.outlook.com (2603:10b6:208:44c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 22:14:59 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 22:14:59 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner
	<brauner@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Jan Kara
	<jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Dmitry Antipov
	<dmantipov@yandex.ru>,
        David Sands <david.sands@biamp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Chris Wulff
	<chris.wulff@biamp.com>
Subject: [PATCH v3] usb: gadget: f_fs: add capability for dfu run-time
 descriptor
Thread-Topic: [PATCH v3] usb: gadget: f_fs: add capability for dfu run-time
 descriptor
Thread-Index: AQHalokpimGT++aQ2k6Ic/g3VTUYsQ==
Date: Wed, 24 Apr 2024 22:14:58 +0000
Message-ID: 
 <CO1PR17MB54197F118CBC8783D289B97DE1102@CO1PR17MB5419.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|IA1PR17MB6925:EE_
x-ms-office365-filtering-correlation-id: 88b269f1-e786-4d73-2573-08dc64abfacc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?/H6jM8Ana/zzCRg5BQ50DBwKRVBrsgPl1Pam4vh1as3pKapdMMmYWmDPz+?=
 =?iso-8859-1?Q?Rmw/LfIVQwKHZPhq1+yudIVmtXlCMeHXYiu8VojotZj2ca6GD7YefrPIFI?=
 =?iso-8859-1?Q?GkHRQ9aSqZZbQ6qyE/Mtwq7x+CUUwnv3bPMDyTr8gX//4Ya9V3aHjC+Le5?=
 =?iso-8859-1?Q?Q0ECzfZiycfXzQTv1ymBNoDAdk5phmGKQjSPoYGDclSx+fdfBG9o5OsOSb?=
 =?iso-8859-1?Q?NJVheceL85ljg3xHi8Z29uhc9kanCIoU4uRJ1LrqIxIjZj3npDLf2h3Utx?=
 =?iso-8859-1?Q?+TyItlbpJ5bjIsRFhNgeBh5IbwmRsdl2UZkEu92oqUBktt/Vf/MnqxUV6c?=
 =?iso-8859-1?Q?fMMq1rZMprYMNMEx7SdRueYljTAmFVaiy3GF4IbYfLhZgL5mayLqzMS2Dr?=
 =?iso-8859-1?Q?s9r9UKoveUOBBkhlbxfpe1JhT1bPiYUKUvCuJX+dhSU7GRSRADzUN/u8ov?=
 =?iso-8859-1?Q?jYA4vTTGgqU+6vO36y2PRqCuDufVJixJG5eLeCEveu4wbkzO00WVi1Ij57?=
 =?iso-8859-1?Q?dWlVVcwbNEoUeuKPhjvUSm1z4KC5JRMSCfr4HT15n6Iyn9UiBJuJ3EUR3R?=
 =?iso-8859-1?Q?Q7TlnMNYww+8GLD3X4stDf/O5j+MooGpJtrJIzuaixpWhwgrNsVwX1qd9M?=
 =?iso-8859-1?Q?4bepeo6Z+W4f5ABKrfETrDdd3cZW8nWSE7g+5vkUNE9Zfqe8d0KPqB+uA8?=
 =?iso-8859-1?Q?fjVGfSWcy1Y5LsGNBQAC9yd7kuRldJ8EI13hMzyqOqjWoJS3kNXboKmyyB?=
 =?iso-8859-1?Q?TRjx2Ivk9dQBXA+b6hzmclLOsmXQ9gE/urnfs3j4l3HCALPbBdz9tCUiNo?=
 =?iso-8859-1?Q?6FGKXNyPV7GmNs7pcVmHGBj9ao2iXcqhn4JavsK7pJkKoO1v/xq/Hi3RmX?=
 =?iso-8859-1?Q?IwB9Nl3OSNw2DOUILrC0iNB7fefpLLLSzmsssKIpYHQDjTbtPAs75cfqGJ?=
 =?iso-8859-1?Q?0WeMtLioVNC8lGHv8B3gsn7J2+ZkvchsST8+lUBCtiP2zVfOdy37mndRVh?=
 =?iso-8859-1?Q?QNhCtsGwlfzdej+qFDEfi+K7AdWX2Qvc9ZqN+z9nGnnnuPhpG2KkblzSMl?=
 =?iso-8859-1?Q?1YH+Kq/OVAmlEIvraCFRl4TbIIgDbhX/6wKrfV8Vjd9uu0iPBxy1z/elh5?=
 =?iso-8859-1?Q?r++PwWdBuTi/5wHqgx3b9iUx364M6vKX3imPcMNM+QG9jgKauW4DpesJ9f?=
 =?iso-8859-1?Q?wLgmosaGhrj+UkwV/cRF3UiEiWm80Kez8TZT9n5z6PiI+3Wzq062TGwMIy?=
 =?iso-8859-1?Q?I8JvML5D08I+Aq8afyqpcYbBLbmvaOVdoUiZW6nDFZM8urp4Vy25S1gtSA?=
 =?iso-8859-1?Q?8qPY1Zj2tAmW+faTlettacf6/SpjtRd+VqV3SYbgw6wHHVZTbNFBCcDcKG?=
 =?iso-8859-1?Q?RcYwxuAypB3weH/eYDETF87a7JapbEyA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?pLrESmVjDqxxkmtwDbptNLrXzpzuq6kCVtKQOX/DnMwRTsS3ZRFtNEQqby?=
 =?iso-8859-1?Q?Ul/hZpVBADLJEmIc/DzQkm/aVWBbwVk2v7u1zLV2zu652dwY6qSuxS8cnC?=
 =?iso-8859-1?Q?HSsqelOXXY3aWCCF92cRi7PWkeJFfJpzRKebEEDwBwqSo3hWRuDrAPcaYr?=
 =?iso-8859-1?Q?coD0ZlrxLdELQGMa2Dvyfbycc1+imKhNWzT8ISCZJ7IMZrYy+Q8ACNhhzy?=
 =?iso-8859-1?Q?E0dTrU19AsS6ktzEI6P57NN/EWnPsOPi4iYGM5LK0Vs92bpk0JaAN62qDa?=
 =?iso-8859-1?Q?Ghr3h0QEy0B19iOM79vO0bwDBrilKiwljy3IHEJwOP0QtZdPxXcuOMFzDP?=
 =?iso-8859-1?Q?gqy4Yy1qePRNdXBVJ/TDtoSbjhyXAGHgBAe9b4HXzWlxgRhYvXXrN9vfB9?=
 =?iso-8859-1?Q?ye2OayPvusCPU4ZmQqTpW/6K3vTMxy8qrZs7714IKdn9X8WmD/81jPak1q?=
 =?iso-8859-1?Q?0FCBDI9oZoX12aTxyHif/wkmvBxMNu6aaRBc56gSlZ220WyRwR15nefe4z?=
 =?iso-8859-1?Q?t6SW7v+MBuAsGrL3oDvq0QD/NyammvWGzlo7sBHY0BHCfLgY1/sWFz2CrH?=
 =?iso-8859-1?Q?Z9DRIl3w5NiBbXdgpGkUXJ6pgNGngNOGSREUqVyTjaXNK71Ea30T+ZGXrn?=
 =?iso-8859-1?Q?9On/WecS4KGd72aHCSsg5gXg5atdpaGLWJOX6Ddu4KVO1iQOd5aGJnqVPn?=
 =?iso-8859-1?Q?9RfsH5u93ftf4v5aifwBt75LZSglhxkz1VtwEU07m9gCX4HIDm/QKO8a9H?=
 =?iso-8859-1?Q?vHFEDPgJQzhuu70R7LjF2YmaAOXE8l5DNnS2DTfsWuppdBrdi3chALObaI?=
 =?iso-8859-1?Q?A+/g0G9+wwADwUnRs6wOPuCG3JyISp2PPFuNHFhhjuB7PROK9cho8sjJ/w?=
 =?iso-8859-1?Q?XRv/2Dmu5hic9xLh/ALoqjTV7mHAcr+YZpm6wjN6OLWEPdhuHUFdDZIdA+?=
 =?iso-8859-1?Q?JrceUZtGBFXR1EbHTRIz3SOsYK45GTce77koqn1Q4BipOLYffNaULnZq28?=
 =?iso-8859-1?Q?4HphMkNKJyBhVumjjonJYSuOvZALWp5ubTlJlFueWVxGFwSdYRte+WarRl?=
 =?iso-8859-1?Q?eIIxHbTneB89svAhYnxOGvkJSlQUVQ9KAun3z11nFx4docPOgTU2m+syUO?=
 =?iso-8859-1?Q?Wi/VAaCJx/J52NQMFHtpLwThMJkydjL64qZkmREDtzx5noLEu2txduTI5m?=
 =?iso-8859-1?Q?mUPScciCAsrqEZCtJT/9vt45lOtxlBat6/AqBswXdk/huC/wBdMjBGwZ/N?=
 =?iso-8859-1?Q?qvj+bwv+nT4M//C/miQDWAZ9SG9ByfUIOWjnIG0MUjRDevge7MDk9PoQwR?=
 =?iso-8859-1?Q?a1xco1/crXUyZBM8iyI7pCAmzuU3n8TWwCaE6jJZCc5ABxyE6gpirtwX4v?=
 =?iso-8859-1?Q?Y/YjqKG8MNgxtm/lGzZi7w95T6SZYKD+eBYFOB0atDGHMH7wL9Gd5DuUlT?=
 =?iso-8859-1?Q?sNS5WSObTQeUYPz7Lco9Gqtpt+HciiByad1NL106dJUFh1y0dqf2lU+sPr?=
 =?iso-8859-1?Q?Z5q9hy0YM2WftHGsJJDs14kRuoHQL1WjFaW6YZfTCqlsflqdCCSzW6n5v2?=
 =?iso-8859-1?Q?pwBj7TeKJO7HCrl2DQTxaydM3lZbr5VwNhWhnds7F3hsMMkrho183G/yP3?=
 =?iso-8859-1?Q?rGE+KTGlF8XhctKJsoInGER4bwmJAGnfbN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5419.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b269f1-e786-4d73-2573-08dc64abfacc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 22:14:58.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCBbZLHLS2+P4jBF8iITCLryPW0bf5saQV/lXtUz6NfdPeODj7zp1ZuxAW669jZ/WtZz4XwY4QKAD7liK2oHig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6925
X-Proofpoint-ORIG-GUID: BzTDxwGfd18FFd6eKPd8erFCiS6KW5W8
X-Proofpoint-GUID: BzTDxwGfd18FFd6eKPd8erFCiS6KW5W8

From: David Sands <david.sands@biamp.com>=0A=
=0A=
Add the ability for FunctionFS driver to be able to create DFU Run-Time=0A=
descriptors.=0A=
=0A=
Signed-off-by: David Sands <david.sands@biamp.com>=0A=
Co-developed-by: Chris Wulff <chris.wulff@biamp.com>=0A=
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>=0A=
---=0A=
v3: Documentation, additional constants and constant order fixed=0A=
v2: https://lore.kernel.org/linux-usb/CO1PR17MB54198D086B61F7392FA9075FE10E=
2@CO1PR17MB5419.namprd17.prod.outlook.com/=0A=
v1: https://lore.kernel.org/linux-usb/CO1PR17MB5419AC3907C74E28D80C5021E108=
2@CO1PR17MB5419.namprd17.prod.outlook.com/=0A=
=0A=
 drivers/usb/gadget/function/f_fs.c  | 12 ++++++++++--=0A=
 include/uapi/linux/usb/ch9.h        |  9 +++++++--=0A=
 include/uapi/linux/usb/functionfs.h | 25 +++++++++++++++++++++++++=0A=
 3 files changed, 42 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/functi=
on/f_fs.c=0A=
index bffbc1dc651f..4cc3f3601cf0 100644=0A=
--- a/drivers/usb/gadget/function/f_fs.c=0A=
+++ b/drivers/usb/gadget/function/f_fs.c=0A=
@@ -2467,7 +2467,7 @@ typedef int (*ffs_os_desc_callback)(enum ffs_os_desc_=
type entity,=0A=
 =0A=
 static int __must_check ffs_do_single_desc(char *data, unsigned len,=0A=
 					   ffs_entity_callback entity,=0A=
-					   void *priv, int *current_class)=0A=
+					   void *priv, int *current_class, int *current_subclass)=0A=
 {=0A=
 	struct usb_descriptor_header *_ds =3D (void *)data;=0A=
 	u8 length;=0A=
@@ -2524,6 +2524,7 @@ static int __must_check ffs_do_single_desc(char *data=
, unsigned len,=0A=
 		if (ds->iInterface)=0A=
 			__entity(STRING, ds->iInterface);=0A=
 		*current_class =3D ds->bInterfaceClass;=0A=
+		*current_subclass =3D ds->bInterfaceSubClass;=0A=
 	}=0A=
 		break;=0A=
 =0A=
@@ -2548,6 +2549,12 @@ static int __must_check ffs_do_single_desc(char *dat=
a, unsigned len,=0A=
 			if (length !=3D sizeof(struct ccid_descriptor))=0A=
 				goto inv_length;=0A=
 			break;=0A=
+		} else if (*current_class =3D=3D USB_CLASS_APP_SPEC &&=0A=
+			   *current_subclass =3D=3D USB_SUBCLASS_DFU) {=0A=
+			pr_vdebug("dfu functional descriptor\n");=0A=
+			if (length !=3D sizeof(struct usb_dfu_functional_descriptor))=0A=
+				goto inv_length;=0A=
+			break;=0A=
 		} else {=0A=
 			pr_vdebug("unknown descriptor: %d for class %d\n",=0A=
 			      _ds->bDescriptorType, *current_class);=0A=
@@ -2610,6 +2617,7 @@ static int __must_check ffs_do_descs(unsigned count, =
char *data, unsigned len,=0A=
 	const unsigned _len =3D len;=0A=
 	unsigned long num =3D 0;=0A=
 	int current_class =3D -1;=0A=
+	int current_subclass =3D -1;=0A=
 =0A=
 	for (;;) {=0A=
 		int ret;=0A=
@@ -2629,7 +2637,7 @@ static int __must_check ffs_do_descs(unsigned count, =
char *data, unsigned len,=0A=
 			return _len - len;=0A=
 =0A=
 		ret =3D ffs_do_single_desc(data, len, entity, priv,=0A=
-			&current_class);=0A=
+			&current_class, &current_subclass);=0A=
 		if (ret < 0) {=0A=
 			pr_debug("%s returns %d\n", __func__, ret);=0A=
 			return ret;=0A=
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h=0A=
index 44d73ba8788d..7f155fba0c1f 100644=0A=
--- a/include/uapi/linux/usb/ch9.h=0A=
+++ b/include/uapi/linux/usb/ch9.h=0A=
@@ -254,6 +254,9 @@ struct usb_ctrlrequest {=0A=
 #define USB_DT_DEVICE_CAPABILITY	0x10=0A=
 #define USB_DT_WIRELESS_ENDPOINT_COMP	0x11=0A=
 #define USB_DT_WIRE_ADAPTER		0x21=0A=
+/* From USB Device Firmware Upgrade Specification, Revision 1.1 */=0A=
+#define USB_DT_DFU_FUNCTIONAL		0x21=0A=
+/* these are from the Wireless USB spec */=0A=
 #define USB_DT_RPIPE			0x22=0A=
 #define USB_DT_CS_RADIO_CONTROL		0x23=0A=
 /* From the T10 UAS specification */=0A=
@@ -263,6 +266,7 @@ struct usb_ctrlrequest {=0A=
 /* From the USB 3.1 spec */=0A=
 #define	USB_DT_SSP_ISOC_ENDPOINT_COMP	0x31=0A=
 =0A=
+=0A=
 /* Conventional codes for class-specific descriptors.  The convention is=
=0A=
  * defined in the USB "Common Class" Spec (3.11).  Individual class specs=
=0A=
  * are authoritative for their usage, not the "common class" writeup.=0A=
@@ -329,9 +333,10 @@ struct usb_device_descriptor {=0A=
 #define USB_CLASS_USB_TYPE_C_BRIDGE	0x12=0A=
 #define USB_CLASS_MISC			0xef=0A=
 #define USB_CLASS_APP_SPEC		0xfe=0A=
-#define USB_CLASS_VENDOR_SPEC		0xff=0A=
+#define USB_SUBCLASS_DFU			0x01=0A=
 =0A=
-#define USB_SUBCLASS_VENDOR_SPEC	0xff=0A=
+#define USB_CLASS_VENDOR_SPEC		0xff=0A=
+#define USB_SUBCLASS_VENDOR_SPEC		0xff=0A=
 =0A=
 /*------------------------------------------------------------------------=
-*/=0A=
 =0A=
diff --git a/include/uapi/linux/usb/functionfs.h b/include/uapi/linux/usb/f=
unctionfs.h=0A=
index 9f88de9c3d66..6d2061500184 100644=0A=
--- a/include/uapi/linux/usb/functionfs.h=0A=
+++ b/include/uapi/linux/usb/functionfs.h=0A=
@@ -37,6 +37,31 @@ struct usb_endpoint_descriptor_no_audio {=0A=
 	__u8  bInterval;=0A=
 } __attribute__((packed));=0A=
 =0A=
+/**=0A=
+ * struct usb_dfu_functional_descriptor - DFU Functional descriptor=0A=
+ * @bLength:		Size of the descriptor (bytes)=0A=
+ * @bDescriptorType:	USB_DT_DFU_FUNCTIONAL=0A=
+ * @bmAttributes:	DFU attributes=0A=
+ * @wDetachTimeOut:	Maximum time to wait after DFU_DETACH (ms, le16)=0A=
+ * @wTransferSize:	Maximum number of bytes per control-write (le16)=0A=
+ * @bcdDFUVersion:	DFU Spec version (BCD, le16)=0A=
+ */=0A=
+struct usb_dfu_functional_descriptor {=0A=
+	__u8  bLength;=0A=
+	__u8  bDescriptorType;=0A=
+	__u8  bmAttributes;=0A=
+	__le16 wDetachTimeOut;=0A=
+	__le16 wTransferSize;=0A=
+	__le16 bcdDFUVersion;=0A=
+} __attribute__ ((packed));=0A=
+=0A=
+/* from DFU functional descriptor bmAttributes */=0A=
+#define DFU_FUNC_ATT_WILL_DETACH		(1 << 3)=0A=
+#define DFU_FUNC_ATT_MANIFEST_TOLERANT		(1 << 2)=0A=
+#define DFU_FUNC_ATT_CAN_UPLOAD			(1 << 1)=0A=
+#define DFU_FUNC_ATT_CAN_DOWNLOAD		(1 << 0)=0A=
+=0A=
+=0A=
 struct usb_functionfs_descs_head_v2 {=0A=
 	__le32 magic;=0A=
 	__le32 length;=0A=
-- =0A=
2.34.1=0A=
=0A=

