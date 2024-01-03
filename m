Return-Path: <linux-kernel+bounces-15374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EC8822B15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D09B22C9E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC9818AE8;
	Wed,  3 Jan 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="xCx/myYL";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="xCx/myYL";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="xCx/myYL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2106.outbound.protection.outlook.com [40.107.24.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773E18AE6;
	Wed,  3 Jan 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=EvhQWfTa9KiprfIKRXpqIdLss7uQ4+k7cnuel1l6Mv+D9XNcYGvrSQ4k6Qx+YX6hYygSM89c8gGNiRZSSDaPrA+CY+BiM/jYby+iuqrG9F3ABMqlcH9/JGOmllMQ+vOJmrzEG2LNwegH58HXX+kaBhYHJeJFnFx8hABw9gFotAaF85MWJXzbFtLz1jqLJPpgqK5P9V0tquPuL9R9IM75BJwPO4lcN3RfBk3e+zEPEfzJUuG1MUPkOqLooLNHucVbV0rQJsa55T/hXD3DpGlYajNYlxn18aTDXDyshd8mIEUJDwW9G0nD8NagDBIjM1guY3cMYI5SZtXRuygjugAQUw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjgbKm+Wz2Gs1O2mrRxYWaEBHdGZq7DUQ+Tjl9ncdSg=;
 b=eC2+AI8T7aIF52fL4jf7H2Fw0H0gcYBLmQkIFU+sQFIQPiq28HXJy2FMhdq+3NStYR9iH6C4O44JAiDkI9TDoyOY/TuQGQ1tHS+DiaH6Qe8h7GZbofG4b+iZImlS0PNe/z2Hs2bqnieKvv3rIiWjCb8z2W+B5cLUoqZ8mwIVuegwl8nTy/g5WIkTnhpBOH1p0xrAA1MInueCB5TujaprLk+gRedvSi4En1Q+CQpYDiisD6nvIUioGfhqs3lACoW6ZQsojeaFQWpuScBTrlxMAGYktwmSXF9kjiObMEge4JhcSKUqHBNWtlBTErNuxgna9sC2yqxBIK80YWqUBDQmqA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 194.38.86.34) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; dkim=pass (signature
 was verified) header.d=duagon.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,2,smtp.mailfrom=duagon.com] dkim=[1,2,header.d=duagon.com]
 dmarc=[1,2,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjgbKm+Wz2Gs1O2mrRxYWaEBHdGZq7DUQ+Tjl9ncdSg=;
 b=xCx/myYLuK9bI0oahkI0qADd/b312hcEuJAOse738T7D2zXombxGh84bfL4/jNQ06mcyNZZhe0kbeBEqy1/BlIijPUtT0D4lPbC9FOnD7Mq2W5uH4F37N/OOuXZUVi6+XDU3o1j4XqZtc2dI8krhGiJesT3on8b0rukA2ULAwZ0=
Received: from AM0PR02CA0157.eurprd02.prod.outlook.com (2603:10a6:20b:28d::24)
 by GV0P278MB0130.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 10:12:07 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::9) by AM0PR02CA0157.outlook.office365.com
 (2603:10a6:20b:28d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Wed, 3 Jan 2024 10:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 10:12:06 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4T4lrQ5RpDzxpC;
	Wed,  3 Jan 2024 11:12:06 +0100 (CET)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Wed,  3 Jan 2024 11:12:06 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ULRNlrNnWZY/PoHKb+Fcb0oHWd5oEb2j6fMaS5FVseDa6ESss8prSoKmF0EdNrijh3rCS7NBxC//zZBn9Lhf2zSJk/nc5sbWlRHSnCUxOrx+uxnLo/MoGI//rJQYsiNPIcI9dPnFdSnPUmZ7yvob16lUrFaXBjAgcPq+19jbhQXf0NjgIsKCpvutZluo+6EJ+H/j5KGYTcpfcgUX4Jg3UoHeZg9U/FlPWWCDdOpJs+xi68m9h97cprycDyw4m7JBClC7wNz/gyXJdxLgBrPln/Gx8j+av+Qf6w5AsUTpyyVxu2q40QqIpvVfx/WmbB/UymJdmjP/snUYEx/iPp1EaQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjgbKm+Wz2Gs1O2mrRxYWaEBHdGZq7DUQ+Tjl9ncdSg=;
 b=E9RohQsN9w2Vx1rdrBjc4fA9fq71ol/I8KUjOa2NKrSTErrB2VxU1Tf2FzNSCByCwEtV1oeVg3k/+Azb9hh5YxVZ0Tn2TcLMZAsv2EpRcGXZCvECQLCFAy2KutCh5M/j4t1Vim8/hgwEJpBGLS5YkA6onfK7TCSc6B8cU11oG84w+kD/FaMCB52cJQQHKAwuID+2FMIupgvwzMMUkCRPLmSFRZM5xgYvhdAjceDsNRMkVNeF/lasSSv28/hlNjsS3PrqBxVIE9FshJoIWPWQqPvm3DRui1ZGuSNgQnNnaDm2GUACqKdehP+gH0zJUaQ0bjS6hyjyvcA2N8RKHZ4qrw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=lunn.ch smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=pass
 (signature was verified) header.d=duagon.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjgbKm+Wz2Gs1O2mrRxYWaEBHdGZq7DUQ+Tjl9ncdSg=;
 b=xCx/myYLuK9bI0oahkI0qADd/b312hcEuJAOse738T7D2zXombxGh84bfL4/jNQ06mcyNZZhe0kbeBEqy1/BlIijPUtT0D4lPbC9FOnD7Mq2W5uH4F37N/OOuXZUVi6+XDU3o1j4XqZtc2dI8krhGiJesT3on8b0rukA2ULAwZ0=
Received: from AS8PR07CA0035.eurprd07.prod.outlook.com (2603:10a6:20b:459::27)
 by ZR0P278MB1025.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:56::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 10:12:04 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:20b:459:cafe::63) by AS8PR07CA0035.outlook.office365.com
 (2603:10a6:20b:459::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Wed, 3 Jan 2024 10:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 10:12:03 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.40) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 03 Jan 2024 10:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHSTZBasmNBF2mkvxAmaEa1dGm4XEb7h8n4KT97vixv82njZFKjMEwb2yXj3MHyWL2JoVlrmqQD+6/EVitwyebywuDqCbREJ4ZDq8KnWJ7aYgz4do2oZEADLciLJBGqtqw1I3GIuhfH+owXGaurpiwDEymxaKTzR0f/kIZE/XOicTDtN1hXYgVCTYqchQa7kSDiymWxEktLyNxHiVwZB6k+lMQHC+xNqDDePCVtKo4ojhFLsY3qiN2yWysBlVnByAsyjHPpCS3rnO+81A0sXDUYd0EWJmj673FYmlBW2vMUXlXotHGvbzPwyUGQylAtzlH2S+vUm5do4bHqBmAAEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjgbKm+Wz2Gs1O2mrRxYWaEBHdGZq7DUQ+Tjl9ncdSg=;
 b=LK1/LvCe/nSEcU8iJLa8w+/wvuu2ecPHQrG9p3poywZIJFiM61mdQcXJlPj1nAMbhNvJWy+QaPoSpPLgRi6HZqM9WpOpySbitq3X+tlfSCjqJaxMnRIntVRbmc7tX4kT5AvEFyENsrX7j0rBlcSdKivJD7+hi82jiefGZgkbRCsq3EgXKFrFfksTxq0NG1yVsWeW7BlpiXn2arnu3Pq8T/rVC0xqBaBAKKnchzZ64rBxKycReKXYg/HOXu//GIsPLZIL26ELCeIjP57/V1ACerIc60rDUDFW39NHo8+fMSnbNInImDrMKgbqYxRdk3DTtnEIS5HSXnFD7CwjIvrueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjgbKm+Wz2Gs1O2mrRxYWaEBHdGZq7DUQ+Tjl9ncdSg=;
 b=xCx/myYLuK9bI0oahkI0qADd/b312hcEuJAOse738T7D2zXombxGh84bfL4/jNQ06mcyNZZhe0kbeBEqy1/BlIijPUtT0D4lPbC9FOnD7Mq2W5uH4F37N/OOuXZUVi6+XDU3o1j4XqZtc2dI8krhGiJesT3on8b0rukA2ULAwZ0=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by ZRAP278MB0062.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:11::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 10:11:58 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1865:51c9:a91e:c02a%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 10:11:57 +0000
From: =?utf-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?=
	<Jorge.SanjuanGarcia@duagon.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "grygorii.strashko@ti.com"
	<grygorii.strashko@ti.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
Subject: Re: [PATCH 3/3] net: ethernet: ti: am65-cpsw: Add device tree
 property to set max MTU
Thread-Topic: [PATCH 3/3] net: ethernet: ti: am65-cpsw: Add device tree
 property to set max MTU
Thread-Index: AQHaPVRfDFA6sE4cakC8kOOs98f50bDHUXWAgACOcQA=
Date: Wed, 3 Jan 2024 10:11:57 +0000
Message-ID: <2e09402c8cdd1109e730df58df3e59fdb3e5ab53.camel@duagon.com>
References: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
	 <20240102081825.14635-4-jorge.sanjuangarcia@duagon.com>
	 <285f6402-db06-462b-9ca5-8363027283e1@lunn.ch>
In-Reply-To: <285f6402-db06-462b-9ca5-8363027283e1@lunn.ch>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|ZRAP278MB0062:EE_|AMS1EPF0000004D:EE_|ZR0P278MB1025:EE_|AM4PEPF00027A66:EE_|GV0P278MB0130:EE_
X-MS-Office365-Filtering-Correlation-Id: a7cc2c68-06ad-4ee8-6601-08dc0c4470f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 6q+zroOeZIrfjwTsWodKUoCjZXNHVWkyfJmk7b51fWAgKFtxuYuaQKFf8+ZStCWTXYusDs72K/lBAqUco82JfoBWF+0kHofl0MKx6xmtchG00giiWoC1zQnj+YC1enSGvLTr03Pg473he3l6C+9MbgngTS0xL4ssITbuTKFhc2KKL17NlJeMpCWNpGdTSFDKA9A8oWiHxKGb4aUSN1QH8FS4IMRDH8yxK29JhqZbnJZLuz8bED4TJpWSyviUjl4MZKNUUdQOtrOblgFnQ/HArDW08AtMjouT3sm1OoPDLKHgLrWOBfz687R8TL2K+0uUp1zZea8MAEfmhi2hrbfqonerSLoumtVqqku3ZT/bUy0OwdFjXuzUBV2D807jEjYzJWwDEXVT/POfmCn2UptgGRgp8N1d0D/+fUU0cVgkbGSnytG+aDTCoOkySbzaPDPH3CY011pv8ToToJded8glGEXPFPfx95sTNI/eFHedJ6dId6eDKJKLjpeNekFI+Pg54FYe5LZMjsobtvO+l9X1YG+Rb6/xF8LfFelkv5JskDw/bRR9lWnLT5oRcvqCwT5KaGgGeUe7nIGbw0vmyw4xKTQ+/SD4fqO8afjeL/raMURhzvpJw2w41fQtNtmc43hm1HeC5LcPpEwjcSN89fAwEg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39850400004)(366004)(230922051799003)(186009)(1590799021)(64100799003)(1800799012)(451199024)(85202003)(85182001)(36756003)(1580799018)(66446008)(64756008)(6916009)(91956017)(66476007)(6512007)(6506007)(66556008)(76116006)(66946007)(6486002)(38070700009)(86362001)(38100700002)(41300700001)(122000001)(2616005)(26005)(2906002)(5660300002)(71200400001)(478600001)(966005)(4326008)(8676002)(8936002)(316002)(54906003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0BDFB2BA756234D91A52429D18F56B8@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0062
X-CodeTwo-MessageID: 660b75e1-7a99-4ca5-93b5-c94786c462b9.20240103101159@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 626ea034-0e7a-4e15-d697-08dc0c446b3e
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 wzTZeqYgF81Zuj3tZwTnI6W+C5KDlMzSkIC0+FZ9gTbBn4hIf8lA8weuf6PiFWNSCo7VE6yFHJvF8/4OblPgHxfi/RXXnkgrwme2EyXOBAT1VKa6ih+JfzjNpYHXtzMFqv7j2FnlE5RIY17mb7Bir0cWkbiYZ4NeAGyOurI44AAaEy8AIsollnsE2HzfRtGo1ZUyvoWza2464Snf7ZRWf7aeOD4uinIfA1VeEpz9whg/Jop9A1Q9oyAOIiu1+gOZs+ucuiNI52Z0VPb1e+vbqyKM7gwE5g7+QYAsKs6J/upOYzN0ljFeSkzdTpa2VhP+/t3WmXsNHPvqcFdBO6j3eGYdB9/z3fvabj16vIHxQpKIRHeD2ZGRW1G8lNuTSKZuLgU4ri+b/86G760hpGReN8VDxTd3EPyG0VYCB8HkK5HgJvTJc6kXnpkbampjMI4Z6GaosllUKogmSiK8gWwUMpMDol4YMEO/DlToK02Ai9uHuUnbYuSnHcY2+/kr7kmw5456O0TuHVvZ6AWHtmzOlFXBQN+R6DFXeKZr1qxI7+NCVLWbA/i4Aa3KiJQHbRKnpCsl7mAPdDAHgX6DZI77Ryfej5YZH/7J0vuF62AOlqzk+gJ1FwHT2HP8clXvH1/0DMu3uyIRP+DWCzDK0Sbooom1vuMZ3OuRIo7qnqRuTvaZE7rjnEOPOGv4Gct9VibAR4d020auj0imoDoaJVP+WQRoSPoCCv4o+pl6vtlnsnlsbQhRzn4tGursKbwmqcEZ
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39840400004)(136003)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(1590799021)(46966006)(36840700001)(7636003)(7596003)(356005)(1580799018)(85202003)(85182001)(36756003)(40480700001)(86362001)(26005)(2616005)(966005)(6512007)(6506007)(478600001)(8676002)(54906003)(316002)(8936002)(4326008)(6486002)(47076005)(36860700001)(70206006)(70586007)(6916009)(336012)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1025
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b4c762c0-42ed-4502-a652-08dc0c446efa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/rrFUhReNHnHLO573UzGNHV5ztrSzaVMKr2E3TT6UHG5Kyfvp23XxOyPgfKvnVGXmlQ9BE/OOX0RaDYNuy/1kwpJNjiy430cuiEGv1RdUkvc7IyCBHnGmlcpevYBA2g5A/OmwDS15nZ9uNbDx069uTi/FZXMPakNXfhio2cbwt0uqVYXVPdi2WvgRG13mB1OGqvWPkBfqB09SaSXnwQAepE6/GIdeVNVl0AOxja+dxFzc8jdNwXexIDeHAblxMyAgQ9YfdLWpwVgnG7Gwh0SS1BsBruB3eM1F9gKt5zoQpVmK3zPj+qk2ds/q8y/yfOGkhmFMlII4cKOz3tZUv0h+VbuVDMA0sbUDU3KX5rR3Zi2Nad8PhqkQFiXAYAvvAig/OcbeQozMWV9x3jRmzKkAKKf1TNxxkGlffW7ZlMyAc0hC0IcuFOFY8IM2t7nrOeolDq/Dx9F9AT56R42G3XENvZ0KtxSw+R8jjBPK5yMLOxHBzCU9yyPG4OyL7tPwovpE1ULvYlVZDYsYhHJT+pGfIHznhITTw+WjduvIaw267jbPBMEjFC8jpELbV+xCO4F9E1Ee1RgBG8rdbj+8WusQggLnXUznUeGjfr+w4itcyjcTDmsH2RSC8Ue3FIuz0GiBWNPL4tFcTBKZNw5gVkAGMirGjT/A5Qz+aw9bKi1uE3PZyk18MX5ss+w5FhowANc50H0Soub9I18M7bQl3O4z8jkD5/d8lS6moPR/aCthzRSrpOcI1/CecvviUpKgvgOvHuLoIxDPkUDMp6hxlGO8g==
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39850400004)(376002)(230922051799003)(82310400011)(1590799021)(186009)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(2906002)(82740400003)(5660300002)(1580799018)(81166007)(36756003)(26005)(6486002)(336012)(85182001)(966005)(478600001)(2616005)(6916009)(40480700001)(70206006)(70586007)(6506007)(6512007)(41300700001)(8676002)(8936002)(86362001)(4326008)(47076005)(85202003)(316002)(54906003)(36860700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:12:06.9838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cc2c68-06ad-4ee8-6601-08dc0c4470f7
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0130

T24gV2VkLCAyMDI0LTAxLTAzIGF0IDAyOjQyICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
W05vIHN1ZWxlIHJlY2liaXIgY29ycmVvIGVsZWN0csOzbmljbyBkZSBhbmRyZXdAbHVubi5jaC4g
RGVzY3VicmEgcG9yDQo+IHF1w6kgZXN0byBlcyBpbXBvcnRhbnRlIGVuDQo+IGh0dHBzOi8vYWth
Lm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbsKgXQ0KPiANCj4gT24gVHVlLCBKYW4g
MDIsIDIwMjQgYXQgMDg6MTk6MTVBTSArMDAwMCwgU2FuanXDoW4gR2FyY8OtYSwgSm9yZ2UNCj4g
d3JvdGU6DQo+ID4gVGhlIHN3aXRjaCBzdXBwb3J0cyBldGhlcm5ldCBmcmFtZSBzaXplcyBiZXR3
ZWVuIDY0IGFuZCAyMDI0IGJ5dGVzDQo+ID4gKGluY2x1ZGluZyBWTEFOKSBhcyBzdGF0ZWQgaW4g
dGhlIHRlY2huaWNhbCByZWZlcmVuY2UgbWFudWFsLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggYWRk
cyBhIG5ldyBkZXZpY2V0cmVlIHByb3BlcnR5IHNvIHRoZSBzd2l0Y2ggcG9ydHMgY2FuDQo+ID4g
YmUgY29uZmlndXJlZCB3aXRoIGFuIE1UVSBoaWdoZXIgdGhhbiB0aGUgc3RhbmRhciAxNTAwIGJ5
dGVzLA0KPiA+IG1ha2luZw0KPiA+IHRoZSBtYXggZnJhbWUgbGVuZ3RoIGNvbmZpZ3VyZWQgb24g
dGhlIHJlZ2lzdGVycyBhbmQgdGhlIG1heF9tdHUNCj4gPiBhZHZlcnRpc2VkIG9uIHRoZSBuZXR3
b3JrIGRldmljZSBjb25zaXN0ZW50Lg0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIGEgZGV2aWNlIHRy
ZWUgcHJvcGVydHkgZm9yIHRoaXM/IEhvdyBtYW55IG90aGVyDQo+IGRyaXZlcnMgaGF2ZSBhIGRl
dmljZSB0cmVlIHByb3BlcnR5IGxpa2UgdGhpcz8gV2h5IG5vdCBzZXQNCj4gbmRldi0+bWF4X210
dSB0byAyMDI0IG1pbnVzIG92ZXJoZWFkcz8NCg0KSGkgQW5kcmV3LA0KDQpUaGVyZSBhcmUgYSBm
ZXcgZHJpdmVycyB0aGF0IHNldCB0aGUgbWF4X210dSBiYXNlZCBvbiAibWF4X2ZyYW1lX3NpemUi
DQpwYXJzZWQgZnJvbSBkZXZpY2UgdHJlZS4gSGVyZSBpcyBhIGxpc3Q6DQoNCmRyaXZlci9uZXQv
ZXRoZXJuZXQvDQogIHN0bWljcm8vc3RtbWFjL3N0bW1hY19wbGF0Zm9ybS5jDQogIGFsdGVyYS9h
bHRlcmFfdHNlX21haW4uYw0KICBzb2Npb25leHQvbmV0c2VjLmMNCiAgaWJtL2VtYWMvY29yZS5j
DQoNCkkgYWxzbyBjb25zaWRlcmVkIGhhcmRjb2RpbmcgdGhpcyB0byB0aGUgbWF4aW11bSBjYXBh
YmlsaXRpZXMgb2YgdGhlIEhXDQpidXQgSSBlbmRlZCBtYWtpbmcgdGhpcyBhIGNvbmZpZ3VyYWJs
ZSBmcmFtZSBzaXplLiBJIGJlbGVpdmUgdGhpcyB3YXkNCml0IGlzIG1vcmUgc3RhYmxlIGFzwqBJ
IGRvbid0IGtub3cgd2hldGhlciB0aGVyZSBtYXkgYmUgYW55IHBlcmZvcm1hbmNlDQppc3N1ZXMg
aWYgd2UgZGVmYXVsdCB0aGUgbWF4IGZyYW1lIHNpemUgb24gdGhlIHN3aXRoIHJlZ2lzdGVycyB0
byBiZQ0Kc29tZXRoaW5nIGRpZmZlcmVudCB0aGFuIHRoZSBzdGFuZGFyZCAxNTIyIGJ5dGVzLiBJ
IG5lZWQgaXQgZm9yIG15IHVzZQ0KY2FzZSB3aGVyZSB0aGVyZSBpcyBhIERTQSBzd2l0Y2ggY29u
bmVjdGVkIHRvIG9uZSBwb3J0IGFuZCBJIG5lZWQgc29tZQ0KZXh0cmEgcm9vbSBmb3IgdGhlIERT
QSBoZWFkZXJzLg0KDQpSZWdhcmRzLA0KSm9yZ2UNCg0KPiANCj4gwqDCoMKgwqDCoMKgwqAgQW5k
cmV3DQoNCg==

