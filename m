Return-Path: <linux-kernel+bounces-24350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A58382BB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7F1B254B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86F5C91F;
	Fri, 12 Jan 2024 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXtCjcXR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B65C8FB;
	Fri, 12 Jan 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705042704; x=1736578704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RxopEEXq8tLKCTAQnpCOKagq0iDIMTEIuHW2p9tul5I=;
  b=BXtCjcXRnrv+9634+WNWtw7hPNjq6WwulKPGKPZvzpPqgkT8S/EWiwsH
   GVWUEsdhOThSQ1M+X+dZwIGShvAONln6nYKHHbGT6cFRw44SHle5z2WE+
   3vZ9/Jj4wh+uK0mFe01DYyZa9LpuFem1HyD9J1EUZjwTFHkq+cbKY3fDp
   g1gZGU9IgGmHd6l6JRagL0T+UpkFevFYBB3pdOuwt+XjvZoWeTDcdBK2/
   X04V7FvtV1FiM7eL31Zi8RzRb4rTtL3GKd6xLj3eKngWDIWpcXBM9UKOK
   +lDbP0st7/DcXv1htoa8/wkY9t/KhCLfOdhw9sbr9PfCpyAioEZkgwDqV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="12456509"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="12456509"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 22:58:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1114131787"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="1114131787"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jan 2024 22:58:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOBUe-0009B8-2C;
	Fri, 12 Jan 2024 06:58:16 +0000
Date: Fri, 12 Jan 2024 14:57:57 +0800
From: kernel test robot <lkp@intel.com>
To: Valentin Caron <valentin.caron@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Valentin Caron <valentin.caron@foss.st.com>
Subject: Re: [PATCH 1/4] serial: stm32: implement prescaler tuning to compute
 low baudrate
Message-ID: <202401121426.pnTJrQes-lkp@intel.com>
References: <20240111152712.1842790-2-valentin.caron@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111152712.1842790-2-valentin.caron@foss.st.com>

Hi Valentin,

kernel test robot noticed the following build errors:

[auto build test ERROR on atorgue-stm32/stm32-next]
[also build test ERROR on tty/tty-testing tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.7 next-20240111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Valentin-Caron/serial-stm32-implement-prescaler-tuning-to-compute-low-baudrate/20240111-233406
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
patch link:    https://lore.kernel.org/r/20240111152712.1842790-2-valentin.caron%40foss.st.com
patch subject: [PATCH 1/4] serial: stm32: implement prescaler tuning to compute low baudrate
config: i386-buildonly-randconfig-003-20240112 (https://download.01.org/0day-ci/archive/20240112/202401121426.pnTJrQes-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121426.pnTJrQes-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121426.pnTJrQes-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/stm32-usart.c:1303:7: error: call to undeclared function 'FIELD_FIT'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1303 |                 if (FIELD_FIT(USART_BRR_MASK, brr)) {
         |                     ^
   1 error generated.


vim +/FIELD_FIT +1303 drivers/tty/serial/stm32-usart.c

  1156	
  1157	static void stm32_usart_set_termios(struct uart_port *port,
  1158					    struct ktermios *termios,
  1159					    const struct ktermios *old)
  1160	{
  1161		struct stm32_port *stm32_port = to_stm32_port(port);
  1162		const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
  1163		const struct stm32_usart_config *cfg = &stm32_port->info->cfg;
  1164		struct serial_rs485 *rs485conf = &port->rs485;
  1165		unsigned int baud, bits, uart_clk, uart_clk_pres;
  1166		u32 usartdiv, mantissa, fraction, oversampling;
  1167		tcflag_t cflag = termios->c_cflag;
  1168		u32 cr1, cr2, cr3, isr, brr, presc;
  1169		unsigned long flags;
  1170		int ret;
  1171	
  1172		if (!stm32_port->hw_flow_control)
  1173			cflag &= ~CRTSCTS;
  1174	
  1175		uart_clk = clk_get_rate(stm32_port->clk);
  1176	
  1177		baud = uart_get_baud_rate(port, termios, old, 0, uart_clk / 8);
  1178	
  1179		uart_port_lock_irqsave(port, &flags);
  1180	
  1181		ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr,
  1182							isr,
  1183							(isr & USART_SR_TC),
  1184							10, 100000);
  1185	
  1186		/* Send the TC error message only when ISR_TC is not set. */
  1187		if (ret)
  1188			dev_err(port->dev, "Transmission is not complete\n");
  1189	
  1190		/* Stop serial port and reset value */
  1191		writel_relaxed(0, port->membase + ofs->cr1);
  1192	
  1193		/* flush RX & TX FIFO */
  1194		if (ofs->rqr != UNDEF_REG)
  1195			writel_relaxed(USART_RQR_TXFRQ | USART_RQR_RXFRQ,
  1196				       port->membase + ofs->rqr);
  1197	
  1198		cr1 = USART_CR1_TE | USART_CR1_RE;
  1199		if (stm32_port->fifoen)
  1200			cr1 |= USART_CR1_FIFOEN;
  1201		cr2 = stm32_port->swap ? USART_CR2_SWAP : 0;
  1202	
  1203		/* Tx and RX FIFO configuration */
  1204		cr3 = readl_relaxed(port->membase + ofs->cr3);
  1205		cr3 &= USART_CR3_TXFTIE | USART_CR3_RXFTIE;
  1206		if (stm32_port->fifoen) {
  1207			if (stm32_port->txftcfg >= 0)
  1208				cr3 |= stm32_port->txftcfg << USART_CR3_TXFTCFG_SHIFT;
  1209			if (stm32_port->rxftcfg >= 0)
  1210				cr3 |= stm32_port->rxftcfg << USART_CR3_RXFTCFG_SHIFT;
  1211		}
  1212	
  1213		if (cflag & CSTOPB)
  1214			cr2 |= USART_CR2_STOP_2B;
  1215	
  1216		bits = tty_get_char_size(cflag);
  1217		stm32_port->rdr_mask = (BIT(bits) - 1);
  1218	
  1219		if (cflag & PARENB) {
  1220			bits++;
  1221			cr1 |= USART_CR1_PCE;
  1222		}
  1223	
  1224		/*
  1225		 * Word length configuration:
  1226		 * CS8 + parity, 9 bits word aka [M1:M0] = 0b01
  1227		 * CS7 or (CS6 + parity), 7 bits word aka [M1:M0] = 0b10
  1228		 * CS8 or (CS7 + parity), 8 bits word aka [M1:M0] = 0b00
  1229		 * M0 and M1 already cleared by cr1 initialization.
  1230		 */
  1231		if (bits == 9) {
  1232			cr1 |= USART_CR1_M0;
  1233		} else if ((bits == 7) && cfg->has_7bits_data) {
  1234			cr1 |= USART_CR1_M1;
  1235		} else if (bits != 8) {
  1236			dev_dbg(port->dev, "Unsupported data bits config: %u bits\n"
  1237				, bits);
  1238			cflag &= ~CSIZE;
  1239			cflag |= CS8;
  1240			termios->c_cflag = cflag;
  1241			bits = 8;
  1242			if (cflag & PARENB) {
  1243				bits++;
  1244				cr1 |= USART_CR1_M0;
  1245			}
  1246		}
  1247	
  1248		if (ofs->rtor != UNDEF_REG && (stm32_port->rx_ch ||
  1249					       (stm32_port->fifoen &&
  1250						stm32_port->rxftcfg >= 0))) {
  1251			if (cflag & CSTOPB)
  1252				bits = bits + 3; /* 1 start bit + 2 stop bits */
  1253			else
  1254				bits = bits + 2; /* 1 start bit + 1 stop bit */
  1255	
  1256			/* RX timeout irq to occur after last stop bit + bits */
  1257			stm32_port->cr1_irq = USART_CR1_RTOIE;
  1258			writel_relaxed(bits, port->membase + ofs->rtor);
  1259			cr2 |= USART_CR2_RTOEN;
  1260			/*
  1261			 * Enable fifo threshold irq in two cases, either when there is no DMA, or when
  1262			 * wake up over usart, from low power until the DMA gets re-enabled by resume.
  1263			 */
  1264			stm32_port->cr3_irq =  USART_CR3_RXFTIE;
  1265		}
  1266	
  1267		cr1 |= stm32_port->cr1_irq;
  1268		cr3 |= stm32_port->cr3_irq;
  1269	
  1270		if (cflag & PARODD)
  1271			cr1 |= USART_CR1_PS;
  1272	
  1273		port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
  1274		if (cflag & CRTSCTS) {
  1275			port->status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
  1276			cr3 |= USART_CR3_CTSE | USART_CR3_RTSE;
  1277		}
  1278	
  1279		for (presc = 0; presc <= USART_PRESC_MAX; presc++) {
  1280			uart_clk_pres = DIV_ROUND_CLOSEST(uart_clk, stm32_usart_presc_val[presc]);
  1281			usartdiv = DIV_ROUND_CLOSEST(uart_clk_pres, baud);
  1282	
  1283			/*
  1284			 * The USART supports 16 or 8 times oversampling.
  1285			 * By default we prefer 16 times oversampling, so that the receiver
  1286			 * has a better tolerance to clock deviations.
  1287			 * 8 times oversampling is only used to achieve higher speeds.
  1288			 */
  1289			if (usartdiv < 16) {
  1290				oversampling = 8;
  1291				cr1 |= USART_CR1_OVER8;
  1292				stm32_usart_set_bits(port, ofs->cr1, USART_CR1_OVER8);
  1293			} else {
  1294				oversampling = 16;
  1295				cr1 &= ~USART_CR1_OVER8;
  1296				stm32_usart_clr_bits(port, ofs->cr1, USART_CR1_OVER8);
  1297			}
  1298	
  1299			mantissa = (usartdiv / oversampling) << USART_BRR_DIV_M_SHIFT;
  1300			fraction = usartdiv % oversampling;
  1301			brr = mantissa | fraction;
  1302	
> 1303			if (FIELD_FIT(USART_BRR_MASK, brr)) {
  1304				if (ofs->presc != UNDEF_REG) {
  1305					port->uartclk = uart_clk_pres;
  1306					writel_relaxed(presc, port->membase + ofs->presc);
  1307				} else if (presc) {
  1308					/* We need a prescaler but we don't have it (STM32F4, STM32F7) */
  1309					dev_err(port->dev,
  1310						"unable to set baudrate, input clock is too high");
  1311				}
  1312				break;
  1313			} else if (presc == USART_PRESC_MAX) {
  1314				/* Even with prescaler and brr at max value we can't set baudrate */
  1315				dev_err(port->dev, "unable to set baudrate, input clock is too high");
  1316				break;
  1317			}
  1318		}
  1319	
  1320		writel_relaxed(brr, port->membase + ofs->brr);
  1321	
  1322		uart_update_timeout(port, cflag, baud);
  1323	
  1324		port->read_status_mask = USART_SR_ORE;
  1325		if (termios->c_iflag & INPCK)
  1326			port->read_status_mask |= USART_SR_PE | USART_SR_FE;
  1327		if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
  1328			port->read_status_mask |= USART_SR_FE;
  1329	
  1330		/* Characters to ignore */
  1331		port->ignore_status_mask = 0;
  1332		if (termios->c_iflag & IGNPAR)
  1333			port->ignore_status_mask = USART_SR_PE | USART_SR_FE;
  1334		if (termios->c_iflag & IGNBRK) {
  1335			port->ignore_status_mask |= USART_SR_FE;
  1336			/*
  1337			 * If we're ignoring parity and break indicators,
  1338			 * ignore overruns too (for real raw support).
  1339			 */
  1340			if (termios->c_iflag & IGNPAR)
  1341				port->ignore_status_mask |= USART_SR_ORE;
  1342		}
  1343	
  1344		/* Ignore all characters if CREAD is not set */
  1345		if ((termios->c_cflag & CREAD) == 0)
  1346			port->ignore_status_mask |= USART_SR_DUMMY_RX;
  1347	
  1348		if (stm32_port->rx_ch) {
  1349			/*
  1350			 * Setup DMA to collect only valid data and enable error irqs.
  1351			 * This also enables break reception when using DMA.
  1352			 */
  1353			cr1 |= USART_CR1_PEIE;
  1354			cr3 |= USART_CR3_EIE;
  1355			cr3 |= USART_CR3_DMAR;
  1356			cr3 |= USART_CR3_DDRE;
  1357		}
  1358	
  1359		if (stm32_port->tx_ch)
  1360			cr3 |= USART_CR3_DMAT;
  1361	
  1362		if (rs485conf->flags & SER_RS485_ENABLED) {
  1363			stm32_usart_config_reg_rs485(&cr1, &cr3,
  1364						     rs485conf->delay_rts_before_send,
  1365						     rs485conf->delay_rts_after_send,
  1366						     baud);
  1367			if (rs485conf->flags & SER_RS485_RTS_ON_SEND) {
  1368				cr3 &= ~USART_CR3_DEP;
  1369				rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
  1370			} else {
  1371				cr3 |= USART_CR3_DEP;
  1372				rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
  1373			}
  1374	
  1375		} else {
  1376			cr3 &= ~(USART_CR3_DEM | USART_CR3_DEP);
  1377			cr1 &= ~(USART_CR1_DEDT_MASK | USART_CR1_DEAT_MASK);
  1378		}
  1379	
  1380		/* Configure wake up from low power on start bit detection */
  1381		if (stm32_port->wakeup_src) {
  1382			cr3 &= ~USART_CR3_WUS_MASK;
  1383			cr3 |= USART_CR3_WUS_START_BIT;
  1384		}
  1385	
  1386		writel_relaxed(cr3, port->membase + ofs->cr3);
  1387		writel_relaxed(cr2, port->membase + ofs->cr2);
  1388		writel_relaxed(cr1, port->membase + ofs->cr1);
  1389	
  1390		stm32_usart_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
  1391		uart_port_unlock_irqrestore(port, flags);
  1392	
  1393		/* Handle modem control interrupts */
  1394		if (UART_ENABLE_MS(port, termios->c_cflag))
  1395			stm32_usart_enable_ms(port);
  1396		else
  1397			stm32_usart_disable_ms(port);
  1398	}
  1399	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

